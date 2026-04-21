import 'package:freezed_annotation/freezed_annotation.dart';
import 'subject_result.dart';

part 'student_result.freezed.dart';

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
