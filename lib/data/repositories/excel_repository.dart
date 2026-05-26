import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'package:e3dad_5odam/domain/models/student_result.dart';
import 'package:e3dad_5odam/domain/models/subject.dart';

// CSV column layout (0-indexed):
//  0  : م
//  1  : إسم الطالب
//  2  : المرحلة
//  3  : لاهوت العقيدي - حضور
//  4  : لاهوت العقيدي - إمتحان
//  5  : لاهوت العقيدي - إجمالي (درجات)
//  6  : لاهوت العقيدي - التقدير
//  7  : التربوي - حضور
//  8  : التربوي - إمتحان
//  9  : التربوي - إجمالي (درجات)
//  10 : التربوي - التقدير
//  11 : لاهوت الطقسي - حضور
//  12 : لاهوت الطقسي - إمتحان
//  13 : لاهوت الطقسي - إجمالي (درجات)
//  14 : لاهوت الطقسي - التقدير
//  15 : العهد الجديد - حضور
//  16 : العهد الجديد - إمتحان
//  17 : العهد الجديد - إجمالي (درجات)
//  18 : العهد الجديد - التقدير
//  19 : العهد القديم - حضور
//  20 : العهد القديم - إمتحان
//  21 : العهد القديم - إجمالي (درجات)
//  22 : العهد القديم - التقدير
//  23 : النتيجة الكلية - المجموع الكلي
//  24 : النتيجة الكلية - النسبة المئوية
//  25 : النتيجة الكلية - تقدير
//  26 : username
//  27 : password
//  28 : عدد مواد الرسوب
//  29 : عدد مواد النجاح

class ExcelRepository {
  List<StudentResult>? _cachedStudents;

  Future<List<StudentResult>> getStudents() async {
    if (_cachedStudents != null) return _cachedStudents!;

    try {
      final String csvString = await rootBundle.loadString(
        'assets/data/student_result.csv',
      );

      final List<List<dynamic>> rows = const CsvToListConverter(
        shouldParseNumbers: false,
      ).convert(
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

      // Each subject occupies 4 consecutive columns starting at [startCol]:
      //  +0 حضور | +1 إمتحان | +2 إجمالي درجات | +3 تقدير
      Subject parseSubject(List<dynamic> row, String name, int startCol) {
        final total = cell(row, startCol + 2);
        return Subject(
          name: name,
          attendance: cell(row, startCol),
          exam: cell(row, startCol + 1),
          totalScore: total,
          percentage: total,
          grade: cell(row, startCol + 3),
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

        final id = cell(row, 0);
        final name = cell(row, 1);
        final stage = cell(row, 2);

        final subjects = [
          parseSubject(row, 'لاهوت عقيدي', 3),
          parseSubject(row, 'التربوي', 7),
          parseSubject(row, 'لاهوت الطقسي', 11),
          parseSubject(row, 'العهد الجديد', 15),
          parseSubject(row, 'العهد القديم', 19),
        ];

        final totalScore = cell(row, 24);
        final totalGrade = cell(row, 25);
        final username = cell(row, 26);
        final password = cell(row, 27);

        students.add(
          StudentResult(
            id: id,
            name: name,
            stage: stage,
            subjects: subjects,
            totalScore: totalScore,
            totalGrade: totalGrade,
            username: username,
            password: password,
          ),
        );
      }

      _cachedStudents = students;
      return students;
    } catch (e, st) {
      // ignore: avoid_print
      print('getStudents error: $e\n$st');
      rethrow;
    }
  }
}
