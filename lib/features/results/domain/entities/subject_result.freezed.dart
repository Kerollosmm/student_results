// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subject_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SubjectResult {
  String get name => throw _privateConstructorUsedError;
  int? get attendance => throw _privateConstructorUsedError;
  int? get exam => throw _privateConstructorUsedError;
  int? get totalDegrees => throw _privateConstructorUsedError;
  double? get totalPercent =>
      throw _privateConstructorUsedError; // 0.76 → display as "76%"
  String? get grade => throw _privateConstructorUsedError;

  /// Create a copy of SubjectResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubjectResultCopyWith<SubjectResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubjectResultCopyWith<$Res> {
  factory $SubjectResultCopyWith(
    SubjectResult value,
    $Res Function(SubjectResult) then,
  ) = _$SubjectResultCopyWithImpl<$Res, SubjectResult>;
  @useResult
  $Res call({
    String name,
    int? attendance,
    int? exam,
    int? totalDegrees,
    double? totalPercent,
    String? grade,
  });
}

/// @nodoc
class _$SubjectResultCopyWithImpl<$Res, $Val extends SubjectResult>
    implements $SubjectResultCopyWith<$Res> {
  _$SubjectResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubjectResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? attendance = freezed,
    Object? exam = freezed,
    Object? totalDegrees = freezed,
    Object? totalPercent = freezed,
    Object? grade = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            attendance: freezed == attendance
                ? _value.attendance
                : attendance // ignore: cast_nullable_to_non_nullable
                      as int?,
            exam: freezed == exam
                ? _value.exam
                : exam // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalDegrees: freezed == totalDegrees
                ? _value.totalDegrees
                : totalDegrees // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalPercent: freezed == totalPercent
                ? _value.totalPercent
                : totalPercent // ignore: cast_nullable_to_non_nullable
                      as double?,
            grade: freezed == grade
                ? _value.grade
                : grade // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubjectResultImplCopyWith<$Res>
    implements $SubjectResultCopyWith<$Res> {
  factory _$$SubjectResultImplCopyWith(
    _$SubjectResultImpl value,
    $Res Function(_$SubjectResultImpl) then,
  ) = __$$SubjectResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    int? attendance,
    int? exam,
    int? totalDegrees,
    double? totalPercent,
    String? grade,
  });
}

/// @nodoc
class __$$SubjectResultImplCopyWithImpl<$Res>
    extends _$SubjectResultCopyWithImpl<$Res, _$SubjectResultImpl>
    implements _$$SubjectResultImplCopyWith<$Res> {
  __$$SubjectResultImplCopyWithImpl(
    _$SubjectResultImpl _value,
    $Res Function(_$SubjectResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubjectResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? attendance = freezed,
    Object? exam = freezed,
    Object? totalDegrees = freezed,
    Object? totalPercent = freezed,
    Object? grade = freezed,
  }) {
    return _then(
      _$SubjectResultImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        attendance: freezed == attendance
            ? _value.attendance
            : attendance // ignore: cast_nullable_to_non_nullable
                  as int?,
        exam: freezed == exam
            ? _value.exam
            : exam // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalDegrees: freezed == totalDegrees
            ? _value.totalDegrees
            : totalDegrees // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalPercent: freezed == totalPercent
            ? _value.totalPercent
            : totalPercent // ignore: cast_nullable_to_non_nullable
                  as double?,
        grade: freezed == grade
            ? _value.grade
            : grade // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SubjectResultImpl implements _SubjectResult {
  const _$SubjectResultImpl({
    required this.name,
    this.attendance,
    this.exam,
    this.totalDegrees,
    this.totalPercent,
    this.grade,
  });

  @override
  final String name;
  @override
  final int? attendance;
  @override
  final int? exam;
  @override
  final int? totalDegrees;
  @override
  final double? totalPercent;
  // 0.76 → display as "76%"
  @override
  final String? grade;

  @override
  String toString() {
    return 'SubjectResult(name: $name, attendance: $attendance, exam: $exam, totalDegrees: $totalDegrees, totalPercent: $totalPercent, grade: $grade)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubjectResultImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.attendance, attendance) ||
                other.attendance == attendance) &&
            (identical(other.exam, exam) || other.exam == exam) &&
            (identical(other.totalDegrees, totalDegrees) ||
                other.totalDegrees == totalDegrees) &&
            (identical(other.totalPercent, totalPercent) ||
                other.totalPercent == totalPercent) &&
            (identical(other.grade, grade) || other.grade == grade));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    attendance,
    exam,
    totalDegrees,
    totalPercent,
    grade,
  );

  /// Create a copy of SubjectResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubjectResultImplCopyWith<_$SubjectResultImpl> get copyWith =>
      __$$SubjectResultImplCopyWithImpl<_$SubjectResultImpl>(this, _$identity);
}

abstract class _SubjectResult implements SubjectResult {
  const factory _SubjectResult({
    required final String name,
    final int? attendance,
    final int? exam,
    final int? totalDegrees,
    final double? totalPercent,
    final String? grade,
  }) = _$SubjectResultImpl;

  @override
  String get name;
  @override
  int? get attendance;
  @override
  int? get exam;
  @override
  int? get totalDegrees;
  @override
  double? get totalPercent; // 0.76 → display as "76%"
  @override
  String? get grade;

  /// Create a copy of SubjectResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubjectResultImplCopyWith<_$SubjectResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
