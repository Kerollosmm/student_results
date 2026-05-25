import 'package:e3dad_5odam/domain/models/subject.dart';

class StudentResult {
  final String id;
  final String name;
  final String stage;
  final List<Subject> subjects;
  final String totalScore;
  final String totalGrade;
  final String username;
  final String password;

  StudentResult({
    required this.id,
    required this.name,
    required this.stage,
    required this.subjects,
    required this.totalScore,
    required this.totalGrade,
    required this.username,
    required this.password,
  });

  static String computeGrade(String totalScore) {
    final score = double.tryParse(totalScore);
    if (score == null) return '-';
    if (score < 50) return 'راسب';
    if (score <= 65) return 'مقبول';
    if (score <= 75) return 'جيد';
    if (score <= 85) return 'جيد جداً';
    if (score <= 100) return 'ممتاز';
    return '-';
  }
}
