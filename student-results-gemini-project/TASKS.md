# TASKS — Student Results App

> Read GEMINI.md first before starting any task.
> Complete phases in order. After each phase run `flutter analyze` and fix all errors.

---

## Phase 1 — Project Bootstrap

- [ ] Run: `flutter create student_results_app --org com.church`
- [ ] Replace `pubspec.yaml` with the dependencies listed in GEMINI.md
- [ ] Create folder: `assets/data/`
- [ ] Copy `student_results.xlsx` → `assets/data/student_results.xlsx`
- [ ] Register asset in `pubspec.yaml` under `flutter.assets`
- [ ] Run `flutter pub get`

---

## Phase 2 — Domain Layer

- [ ] Create `lib/features/results/domain/entities/subject_result.dart` (Freezed)
- [ ] Create `lib/features/results/domain/entities/student_result.dart` (Freezed)
- [ ] Create `lib/features/results/domain/repositories/results_repository.dart` (abstract)
  ```dart
  abstract class ResultsRepository {
    Future<StudentResult?> getStudentByCardId(String cardId);
  }
  ```
- [ ] Run `flutter pub run build_runner build --delete-conflicting-outputs`

---

## Phase 3 — Data Layer

- [ ] Create `lib/features/results/data/datasources/excel_datasource.dart`
  - Use `rootBundle.load('assets/data/student_results.xlsx')`
  - Parse with `excel` package
  - Match card ID after stripping `.0` suffix
  - Return raw row map
- [ ] Create `lib/features/results/data/models/student_result_model.dart`
  - `fromExcelRow(Map<String, dynamic> row)` factory
  - Handles null/NaN → null
  - Handles percentage as double
- [ ] Create `lib/features/results/data/repositories/results_repository_impl.dart`
  - Implements `ResultsRepository`
  - Delegates to `ExcelDatasource`
  - Annotate with `@Injectable(as: ResultsRepository)`

---

## Phase 4 — DI Setup

- [ ] Create `lib/core/di/injection.dart`
  ```dart
  import 'package:get_it/get_it.dart';
  import 'package:injectable/injectable.dart';
  import 'injection.config.dart';

  final getIt = GetIt.instance;

  @InjectableInit()
  void configureDependencies() => getIt.init();
  ```
- [ ] Run `build_runner` again to generate `injection.config.dart`
- [ ] Call `configureDependencies()` in `main.dart` before `runApp`

---

## Phase 5 — Cubit

- [ ] Create `lib/features/results/presentation/cubit/login_state.dart` (Freezed union)
  - `initial`, `loading`, `success(StudentResult)`, `error(String)`
- [ ] Create `lib/features/results/presentation/cubit/login_cubit.dart`
  ```dart
  Future<void> login(String cardId) async {
    emit(const LoginState.loading());
    final result = await _repository.getStudentByCardId(cardId.trim());
    if (result != null) {
      emit(LoginState.success(result));
    } else {
      emit(const LoginState.error('رقم الكارنيه غير صحيح، حاول مرة أخرى'));
    }
  }
  ```
- [ ] Run `build_runner` again

---

## Phase 6 — Router

- [ ] Create `lib/core/router/app_router.dart`
  ```dart
  final appRouter = GoRouter(routes: [
    GoRoute(path: '/', builder: (_, __) => const LoginScreen()),
    GoRoute(
      path: '/results',
      builder: (_, state) => ResultsScreen(student: state.extra as StudentResult),
    ),
  ]);
  ```

---

## Phase 7 — Theme

- [ ] Create `lib/core/theme/app_theme.dart`
  - Use `Cairo` font via `google_fonts`
  - Primary color: amber `#F59E0B`
  - Background: parchment `#FDF6E3`
  - `gradeColor(String? grade)` helper function

---

## Phase 8 — LoginScreen

Build `lib/features/results/presentation/screens/login_screen.dart`:

- Scaffold background: `#FDF6E3`
- Center column (max width 400):
  - Cross/church icon (size 64, amber color)
  - Title "نتائج الطلاب" (28sp, bold, Cairo)
  - Subtitle "أدخل رقم الكارنيه للاطلاع على نتيجتك"
  - Spacer
  - Card with shadow:
    - TextField (numeric, RTL, hint "مثال: 1001")
    - SizedBox(height: 16)
    - BlocConsumer to show loading/error
    - ElevatedButton "عرض النتيجة" (full width, amber)
      - Shows CircularProgressIndicator when loading
      - Disabled when loading
- On `LoginSuccess` state → `context.go('/results', extra: state.student)`
- On `LoginError` state → ScaffoldMessenger red SnackBar

---

## Phase 9 — ResultsScreen

Build `lib/features/results/presentation/screens/results_screen.dart`:

### AppBar
- Title: student name
- Back button → `context.go('/')`

### Body (scrollable column)
1. **Header card**
   - Student name (bold, 20sp)
   - Stage chip (outlined, grey)

2. **Overall result banner**
   - Full-width container, rounded
   - Green bg if overallGrade ≠ "راسب" and overallGrade != null
   - Red bg if overallGrade == "راسب"
   - Large icon: ✓ or ✗
   - Text: "النتيجة الكلية: {overallGrade}" in white

3. **Subject cards** (loop over 5 subjects)
   Each card:
   - Title row: subject name (bold) + grade chip (colored)
   - Divider
   - Row of 4 stats:
     - حضور: {attendance ?? '—'}
     - إمتحان: {exam ?? '—'}
     - إجمالي: {totalDegrees ?? '—'}
     - نسبة: {totalPercent != null ? '${(totalPercent*100).round()}%' : '—'}

---

## Phase 10 — main.dart

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const StudentResultsApp());
}

class StudentResultsApp extends StatelessWidget {
  const StudentResultsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'نتائج الطلاب',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      theme: AppTheme.theme,
      routerConfig: appRouter,
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child!,
      ),
    );
  }
}
```

---

## Phase 11 — Final QA

- [ ] `flutter analyze` → zero errors
- [ ] Test card IDs: `1001`, `1002`, `1099`, `9999` (invalid)
- [ ] Verify percentages show as `%` not decimals
- [ ] Verify null values show `—`
- [ ] Verify grade chips have correct colors
- [ ] Test on web: `flutter run -d chrome`
- [ ] Test on Android emulator
