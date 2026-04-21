# Student Results App — Gemini CLI Context

## Project Goal
Flutter app (mobile + web) where a student enters their **Card ID (رقم الكارنيه)**
and sees their full academic results — read from a **local Excel file bundled inside
`assets/data/student_results.xlsx`**. No Firebase. No internet. 100% offline.

---

## Stack
| Layer | Tech |
|-------|------|
| Framework | Flutter (mobile + web) |
| State Management | flutter_bloc / Cubit |
| DI | get_it + injectable |
| Navigation | go_router |
| Architecture | Clean Architecture |
| Data Models | freezed |
| Excel parsing | excel: ^4.0.6 |
| Fonts | google_fonts (Cairo) |

---

## Data Source — Bundled Excel File
- **Asset path**: `assets/data/student_results.xlsx`
- **Sheet name**: `student_results_clean`
- **Total rows**: 99 students
- **Login key column**: `رقم الكارنيه` (integer, e.g. 1001)

### Column Map
```
م                                    → row index (ignore)
رقم الكارنيه                          → cardId (int → String)
إسم الطالب                            → name
المرحلة                               → stage

لاهوت العقيدي - حضور                 → subjects[0].attendance
لاهوت العقيدي - إمتحان               → subjects[0].exam
لاهوت العقيدي - إجمالي (درجات)       → subjects[0].totalDegrees
لاهوت العقيدي - إجمالي (نسبة مئوية)  → subjects[0].totalPercent  (decimal: 0.76 = 76%)
لاهوت العقيدي - التقدير              → subjects[0].grade

(same pattern for التربوي, لاهوت الطقسي, العهد الجديد, العهد القديم)

النتيجة الكلية - درجات               → overallDegrees
النتيجة الكلية - تقدير               → overallGrade
```

### 5 Subjects in order
1. لاهوت العقيدي
2. التربوي
3. لاهوت الطقسي
4. العهد الجديد
5. العهد القديم

---

## Architecture

```
lib/
├── main.dart
├── core/
│   ├── di/
│   │   └── injection.dart          ← GetIt setup
│   ├── router/
│   │   └── app_router.dart         ← GoRouter: '/' login, '/results' results
│   └── theme/
│       └── app_theme.dart          ← RTL, Cairo font, grade colors
├── features/
│   └── results/
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── student_result.dart     ← Freezed
│       │   │   └── subject_result.dart     ← Freezed
│       │   └── repositories/
│       │       └── results_repository.dart ← abstract
│       ├── data/
│       │   ├── datasources/
│       │   │   └── excel_datasource.dart   ← reads asset Excel
│       │   ├── models/
│       │   │   └── student_result_model.dart
│       │   └── repositories/
│       │       └── results_repository_impl.dart
│       └── presentation/
│           ├── cubit/
│           │   ├── login_cubit.dart
│           │   └── login_state.dart
│           └── screens/
│               ├── login_screen.dart
│               └── results_screen.dart

assets/
└── data/
    └── student_results.xlsx        ← THE LOCAL DATA FILE
```

---

## Domain Entities (Freezed)

### SubjectResult
```dart
@freezed
class SubjectResult with _$SubjectResult {
  const factory SubjectResult({
    required String name,
    int? attendance,
    int? exam,
    int? totalDegrees,
    double? totalPercent,   // 0.76 → display as "76%"
    String? grade,
  }) = _SubjectResult;
}
```

### StudentResult
```dart
@freezed
class StudentResult with _$StudentResult {
  const factory StudentResult({
    required String cardId,
    required String name,
    required String stage,
    required List<SubjectResult> subjects,
    String? overallDegrees,
    String? overallGrade,
  }) = _StudentResult;
}
```

---

## Excel Datasource — Key Logic

```dart
// In excel_datasource.dart
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';

Future<StudentResult?> getStudentByCardId(String cardId) async {
  final bytes = await rootBundle.load('assets/data/student_results.xlsx');
  final excel = Excel.decodeBytes(bytes.buffer.asUint8List());
  final sheet = excel.tables['student_results_clean']!;

  // Row 0 = headers
  final headers = sheet.rows[0].map((c) => c?.value?.toString() ?? '').toList();

  for (int i = 1; i < sheet.rows.length; i++) {
    final row = sheet.rows[i];
    final rowCardId = row[headers.indexOf('رقم الكارنيه')]?.value?.toString()
        .split('.')[0]; // remove decimal from "1001.0"
    if (rowCardId == cardId) {
      return _parseRow(headers, row);
    }
  }
  return null; // not found
}
```

**Important**: Excel package may read integers as `1001.0` — always strip `.0`:
```dart
final clean = val?.toString().replaceAll(RegExp(r'\.0$'), '') ?? '';
```

---

## Cubit States

```dart
// login_state.dart
@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial()                        = LoginInitial;
  const factory LoginState.loading()                        = LoginLoading;
  const factory LoginState.success(StudentResult student)   = LoginSuccess;
  const factory LoginState.error(String message)            = LoginError;
}
```

---

## UI Rules

### General
- Full RTL: wrap `MaterialApp` with `locale: const Locale('ar')` and `Directionality`
- Font: `Cairo` from google_fonts for all text
- No internet required — pure asset read

### LoginScreen (`/`)
- Background: warm parchment `#FDF6E3`
- Centered card with subtle shadow
- Church/cross icon at top (use `Icons.church` or simple cross asset)
- Title: **"نتائج الطلاب"** — large, bold, Cairo
- Subtitle: **"أدخل رقم الكارنيه"**
- TextField: numeric keyboard, RTL, hint "مثال: 1001"
- Button: **"عرض النتيجة"** — full width, warm amber
- Error: red snackbar with message **"رقم الكارنيه غير صحيح، حاول مرة أخرى"**
- Loading: CircularProgressIndicator inside button

### ResultsScreen (`/results`)
- AppBar: student name, back button → clears state
- Header card: name + stage chip
- Overall result banner:
  - PASS (not "راسب"): green `#2E7D32` background
  - FAIL ("راسب"): red `#C62828` background
- Subject cards (5 cards, one per subject):
  - Subject name as card title
  - Grid row: حضور / إمتحان / إجمالي / نسبة% / تقدير
  - Grade chip colored per table below

### Grade Colors
| Grade | Color |
|-------|-------|
| ممتاز | `#2E7D32` (dark green) |
| جيد جدا | `#388E3C` (green) |
| جيد | `#1565C0` (blue) |
| مقبول | `#E65100` (orange) |
| راسب | `#C62828` (red) |
| null/other | `#757575` (grey) |

```dart
Color gradeColor(String? grade) => switch (grade?.trim()) {
  'ممتاز'   => const Color(0xFF2E7D32),
  'جيد جدا' => const Color(0xFF388E3C),
  'جيد'     => const Color(0xFF1565C0),
  'مقبول'   => const Color(0xFFE65100),
  'راسب'    => const Color(0xFFC62828),
  _         => const Color(0xFF757575),
};
```

---

## pubspec.yaml Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.6
  get_it: ^8.0.2
  injectable: ^2.4.4
  freezed_annotation: ^2.4.4
  go_router: ^14.6.2
  excel: ^4.0.6
  google_fonts: ^6.2.1

dev_dependencies:
  build_runner: ^2.4.13
  freezed: ^2.5.7
  injectable_generator: ^2.6.2
  json_serializable: ^6.8.0

flutter:
  assets:
    - assets/data/student_results.xlsx
```

---

## Key Rules Summary
1. **No Firebase, no internet** — data only from bundled asset
2. **Card ID is the only login** — no password
3. **Excel integers come as doubles** — always strip `.0` when comparing
4. **NaN / null values** → display as `—` in UI
5. **Percentages stored as decimals** → multiply × 100 and show `%`
6. **Always RTL** — Arabic UI throughout
