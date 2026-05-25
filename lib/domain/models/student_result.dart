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
    required String totalGrade,
    required this.username,
    required this.password,
  }) : totalGrade = _calculateTotalGrade(subjects, totalScore, totalGrade);

  static String _calculateTotalGrade(
    List<Subject> subjects,
    String totalScoreStr,
    String originalTotalGrade,
  ) {
    // If subjects list is empty (e.g. error/synthetic student result), keep the original grade.
    if (subjects.isEmpty) return originalTotalGrade;

    int passedCount = 0;
    for (final subject in subjects) {
      final grade = subject.grade.trim();
      final isPassed = grade != 'راسب' &&
          grade != 'مؤجل للصيف' &&
          grade != '-' &&
          grade.isNotEmpty;
      if (isPassed) {
        passedCount++;
      }
    }

    // Student must pass at least 3 subjects to avoid failing overall
    if (passedCount < 3) {
      return 'راسب';
    }

    // Determine the grade based on total score percentage
    final cleanScore = totalScoreStr.replaceAll('%', '').trim();
    final double? score = double.tryParse(cleanScore);
    if (score == null) {
      return originalTotalGrade;
    }

    if (score < 50.0) {
      return 'راسب';
    } else if (score < 66.0) {
      return 'مقبول';
    } else if (score < 76.0) {
      return 'جيد';
    } else if (score < 86.0) {
      return 'جيد جداً';
    } else {
      return 'ممتاز';
    }
  }
}
