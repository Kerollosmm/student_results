import 'package:e3dad_5odam/domain/models/subject.dart';

class StudentResult {
  final String id;
  final String name;
  final String stage;
  final List<Subject> subjects;
  final String totalScore;
  final String totalGrade;

  StudentResult({
    required this.id,
    required this.name,
    required this.stage,
    required this.subjects,
    required this.totalScore,
    required this.totalGrade,
  });
}
