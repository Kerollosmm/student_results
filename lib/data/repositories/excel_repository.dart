import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'package:e3dad_5odam/domain/models/student_result.dart';
import 'package:e3dad_5odam/domain/models/subject.dart';

// CSV column layout (0-indexed):
//  0  : م
//  1  : رقم الكارنيه
//  2  : إسم الطالب
//  3  : المرحلة
//  4  : لاهوت العقيدي - حضور
//  5  : لاهوت العقيدي - إمتحان
//  6  : لاهوت العقيدي - إجمالي (درجات)
//  7  : لاهوت العقيدي - إجمالي (نسبة مئوية)
//  8  : لاهوت العقيدي - التقدير
//  9  : التربوي - حضور
//  10 : التربوي - إمتحان
//  11 : التربوي - إجمالي (درجات)
//  12 : التربوي - إجمالي (نسبة مئوية)
//  13 : التربوي - التقدير
//  14 : لاهوت الطقسي - حضور
//  15 : لاهوت الطقسي - إمتحان
//  16 : لاهوت الطقسي - إجمالي (درجات)
//  17 : لاهوت الطقسي - إجمالي (نسبة مئوية)
//  18 : لاهوت الطقسي - التقدير
//  19 : العهد الجديد - حضور
//  20 : العهد الجديد - إمتحان
//  21 : العهد الجديد - إجمالي (درجات)
//  22 : العهد الجديد - إجمالي (نسبة مئوية)
//  23 : العهد الجديد - التقدير
//  24 : العهد القديم - حضور
//  25 : العهد القديم - إمتحان
//  26 : العهد القديم - إجمالي (درجات)
//  27 : العهد القديم - إجمالي (نسبة مئوية)
//  28 : العهد القديم - التقدير
//  29 : النتيجة الكلية - درجات
//  30 : النتيجة الكلية - تقدير

class ExcelRepository {
  List<StudentResult>? _cachedStudents;

  Future<List<StudentResult>> getStudents() async {
    if (_cachedStudents != null) return _cachedStudents!;

    try {
      final String csvString = await rootBundle.loadString(
        'assets/data/student_result.csv',
      );

      final List<List<dynamic>> rows = const CsvToListConverter().convert(
        csvString,
        eol: '\n',
      );

      if (rows.length <= 1) return [];

      String cell(List<dynamic> row, int col) {
        if (col >= row.length) return '-';
        final v = row[col];
        if (v == null) return '-';
        final s = v.toString().trim();
        return s.isEmpty ? '-' : s;
      }

      // Each subject occupies 5 consecutive columns starting at [startCol]:
      //  +0 حضور | +1 إمتحان | +2 إجمالي درجات | +3 نسبة | +4 تقدير
      Subject parseSubject(List<dynamic> row, String name, int startCol) {
        return Subject(
          name: name,
          attendance: cell(row, startCol),
          exam: cell(row, startCol + 1),
          totalScore: cell(row, startCol + 2),
          percentage: cell(row, startCol + 3),
          grade: cell(row, startCol + 4),
        );
      }

      final List<StudentResult> students = [];

      // Start at row index 1 (skip header row)
      for (int i = 1; i < rows.length; i++) {
        final row = rows[i];

        // Skip completely empty rows
        if (row.isEmpty) continue;
        if (row.every((c) => c == null || c.toString().trim().isEmpty)) {
          continue;
        }

        final id = cell(row, 1);
        final name = cell(row, 2);
        final stage = cell(row, 3);

        final subjects = [
          parseSubject(row, 'لاهوت العقيدي', 4),
          parseSubject(row, 'التربوي', 9),
          parseSubject(row, 'لاهوت الطقسي', 14),
          parseSubject(row, 'العهد الجديد', 19),
          parseSubject(row, 'العهد القديم', 24),
        ];

        final totalScore = cell(row, 29);
        final totalGrade = cell(row, 30);

        students.add(
          StudentResult(
            id: id,
            name: name,
            stage: stage,
            subjects: subjects,
            totalScore: totalScore,
            totalGrade: totalGrade,
          ),
        );
      }

      _cachedStudents = students;
      return students;
    } catch (e) {
      return [
        StudentResult(
          id: 'ERROR',
          name: 'خطأ في قراءة الملف: $e',
          stage: 'Error',
          subjects: [],
          totalScore: '-',
          totalGrade: '-',
        ),
      ];
    }
  }
}
