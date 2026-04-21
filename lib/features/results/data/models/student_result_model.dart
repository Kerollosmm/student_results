import '../../domain/entities/student_result.dart';
import '../../domain/entities/subject_result.dart';

class StudentResultModel {
  static StudentResult fromExcelRow(Map<String, dynamic> row) {
    String clean(dynamic val) => val?.toString().replaceAll(RegExp(r'\.0$'), '').trim() ?? '';
    int? toInt(dynamic val) {
      if (val == null) return null;
      final str = clean(val);
      return int.tryParse(str);
    }
    double? toPercent(dynamic val) {
      if (val == null) return null;
      if (val is double) return val;
      if (val is int) return val.toDouble();
      return double.tryParse(val.toString());
    }

    final subjects = <SubjectResult>[];
    
    // Subject 1: لاهوت العقيدي
    subjects.add(SubjectResult(
      name: 'لاهوت العقيدي',
      attendance: toInt(row['لاهوت العقيدي - حضور']),
      exam: toInt(row['لاهوت العقيدي - إمتحان']),
      totalDegrees: toInt(row['لاهوت العقيدي - إجمالي (درجات)']),
      totalPercent: toPercent(row['لاهوت العقيدي - إجمالي (نسبة مئوية)']),
      grade: clean(row['لاهوت العقيدي - التقدير']),
    ));

    // Subject 2: التربوي
    subjects.add(SubjectResult(
      name: 'التربوي',
      attendance: toInt(row['التربوي - حضور']),
      exam: toInt(row['التربوي - إمتحان']),
      totalDegrees: toInt(row['التربوي - إجمالي (درجات)']),
      totalPercent: toPercent(row['التربوي - إجمالي (نسبة مئوية)']),
      grade: clean(row['التربوي - التقدير']),
    ));

    // Subject 3: لاهوت الطقسي
    subjects.add(SubjectResult(
      name: 'لاهوت الطقسي',
      attendance: toInt(row['لاهوت الطقسي - حضور']),
      exam: toInt(row['لاهوت الطقسي - إمتحان']),
      totalDegrees: toInt(row['لاهوت الطقسي - إجمالي (درجات)']),
      totalPercent: toPercent(row['لاهوت الطقسي - إجمالي (نسبة مئوية)']),
      grade: clean(row['لاهوت الطقسي - التقدير']),
    ));

    // Subject 4: العهد الجديد
    subjects.add(SubjectResult(
      name: 'العهد الجديد',
      attendance: toInt(row['العهد الجديد - حضور']),
      exam: toInt(row['العهد الجديد - إمتحان']),
      totalDegrees: toInt(row['العهد الجديد - إجمالي (درجات)']),
      totalPercent: toPercent(row['العهد الجديد - إجمالي (نسبة مئوية)']),
      grade: clean(row['العهد الجديد - التقدير']),
    ));

    // Subject 5: العهد القديم
    subjects.add(SubjectResult(
      name: 'العهد القديم',
      attendance: toInt(row['العهد القديم - حضور']),
      exam: toInt(row['العهد القديم - إمتحان']),
      totalDegrees: toInt(row['العهد القديم - إجمالي (درجات)']),
      totalPercent: toPercent(row['العهد القديم - إجمالي (نسبة مئوية)']),
      grade: clean(row['العهد القديم - التقدير']),
    ));

    return StudentResult(
      cardId: clean(row['رقم الكارنيه']),
      name: clean(row['إسم الطالب']),
      stage: clean(row['المرحلة']),
      subjects: subjects,
      overallDegrees: clean(row['النتيجة الكلية - درجات']),
      overallGrade: clean(row['النتيجة الكلية - تقدير']),
    );
  }
}
