// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StudentResult {
  String get cardId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get stage => throw _privateConstructorUsedError;
  List<SubjectResult> get subjects => throw _privateConstructorUsedError;
  String? get overallDegrees => throw _privateConstructorUsedError;
  String? get overallGrade => throw _privateConstructorUsedError;

  /// Create a copy of StudentResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentResultCopyWith<StudentResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentResultCopyWith<$Res> {
  factory $StudentResultCopyWith(
    StudentResult value,
    $Res Function(StudentResult) then,
  ) = _$StudentResultCopyWithImpl<$Res, StudentResult>;
  @useResult
  $Res call({
    String cardId,
    String name,
    String stage,
    List<SubjectResult> subjects,
    String? overallDegrees,
    String? overallGrade,
  });
}

/// @nodoc
class _$StudentResultCopyWithImpl<$Res, $Val extends StudentResult>
    implements $StudentResultCopyWith<$Res> {
  _$StudentResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardId = null,
    Object? name = null,
    Object? stage = null,
    Object? subjects = null,
    Object? overallDegrees = freezed,
    Object? overallGrade = freezed,
  }) {
    return _then(
      _value.copyWith(
            cardId: null == cardId
                ? _value.cardId
                : cardId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            stage: null == stage
                ? _value.stage
                : stage // ignore: cast_nullable_to_non_nullable
                      as String,
            subjects: null == subjects
                ? _value.subjects
                : subjects // ignore: cast_nullable_to_non_nullable
                      as List<SubjectResult>,
            overallDegrees: freezed == overallDegrees
                ? _value.overallDegrees
                : overallDegrees // ignore: cast_nullable_to_non_nullable
                      as String?,
            overallGrade: freezed == overallGrade
                ? _value.overallGrade
                : overallGrade // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StudentResultImplCopyWith<$Res>
    implements $StudentResultCopyWith<$Res> {
  factory _$$StudentResultImplCopyWith(
    _$StudentResultImpl value,
    $Res Function(_$StudentResultImpl) then,
  ) = __$$StudentResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String cardId,
    String name,
    String stage,
    List<SubjectResult> subjects,
    String? overallDegrees,
    String? overallGrade,
  });
}

/// @nodoc
class __$$StudentResultImplCopyWithImpl<$Res>
    extends _$StudentResultCopyWithImpl<$Res, _$StudentResultImpl>
    implements _$$StudentResultImplCopyWith<$Res> {
  __$$StudentResultImplCopyWithImpl(
    _$StudentResultImpl _value,
    $Res Function(_$StudentResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudentResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardId = null,
    Object? name = null,
    Object? stage = null,
    Object? subjects = null,
    Object? overallDegrees = freezed,
    Object? overallGrade = freezed,
  }) {
    return _then(
      _$StudentResultImpl(
        cardId: null == cardId
            ? _value.cardId
            : cardId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        stage: null == stage
            ? _value.stage
            : stage // ignore: cast_nullable_to_non_nullable
                  as String,
        subjects: null == subjects
            ? _value._subjects
            : subjects // ignore: cast_nullable_to_non_nullable
                  as List<SubjectResult>,
        overallDegrees: freezed == overallDegrees
            ? _value.overallDegrees
            : overallDegrees // ignore: cast_nullable_to_non_nullable
                  as String?,
        overallGrade: freezed == overallGrade
            ? _value.overallGrade
            : overallGrade // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$StudentResultImpl implements _StudentResult {
  const _$StudentResultImpl({
    required this.cardId,
    required this.name,
    required this.stage,
    required final List<SubjectResult> subjects,
    this.overallDegrees,
    this.overallGrade,
  }) : _subjects = subjects;

  @override
  final String cardId;
  @override
  final String name;
  @override
  final String stage;
  final List<SubjectResult> _subjects;
  @override
  List<SubjectResult> get subjects {
    if (_subjects is EqualUnmodifiableListView) return _subjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subjects);
  }

  @override
  final String? overallDegrees;
  @override
  final String? overallGrade;

  @override
  String toString() {
    return 'StudentResult(cardId: $cardId, name: $name, stage: $stage, subjects: $subjects, overallDegrees: $overallDegrees, overallGrade: $overallGrade)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentResultImpl &&
            (identical(other.cardId, cardId) || other.cardId == cardId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.stage, stage) || other.stage == stage) &&
            const DeepCollectionEquality().equals(other._subjects, _subjects) &&
            (identical(other.overallDegrees, overallDegrees) ||
                other.overallDegrees == overallDegrees) &&
            (identical(other.overallGrade, overallGrade) ||
                other.overallGrade == overallGrade));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    cardId,
    name,
    stage,
    const DeepCollectionEquality().hash(_subjects),
    overallDegrees,
    overallGrade,
  );

  /// Create a copy of StudentResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentResultImplCopyWith<_$StudentResultImpl> get copyWith =>
      __$$StudentResultImplCopyWithImpl<_$StudentResultImpl>(this, _$identity);
}

abstract class _StudentResult implements StudentResult {
  const factory _StudentResult({
    required final String cardId,
    required final String name,
    required final String stage,
    required final List<SubjectResult> subjects,
    final String? overallDegrees,
    final String? overallGrade,
  }) = _$StudentResultImpl;

  @override
  String get cardId;
  @override
  String get name;
  @override
  String get stage;
  @override
  List<SubjectResult> get subjects;
  @override
  String? get overallDegrees;
  @override
  String? get overallGrade;

  /// Create a copy of StudentResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentResultImplCopyWith<_$StudentResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
