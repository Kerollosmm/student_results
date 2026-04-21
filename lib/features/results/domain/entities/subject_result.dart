import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_result.freezed.dart';

@freezed
class SubjectResult with _$SubjectResult {
  const factory SubjectResult({
    required String name,
    int? attendance,
    int? exam,
    int? totalDegrees,
    double? totalPercent, // 0.76 → display as "76%"
    String? grade,
  }) = _SubjectResult;
}
