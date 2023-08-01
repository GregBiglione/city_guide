// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_password.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NewPassword {
  String get email => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewPasswordCopyWith<NewPassword> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewPasswordCopyWith<$Res> {
  factory $NewPasswordCopyWith(
          NewPassword value, $Res Function(NewPassword) then) =
      _$NewPasswordCopyWithImpl<$Res, NewPassword>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$NewPasswordCopyWithImpl<$Res, $Val extends NewPassword>
    implements $NewPasswordCopyWith<$Res> {
  _$NewPasswordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NewPasswordCopyWith<$Res>
    implements $NewPasswordCopyWith<$Res> {
  factory _$$_NewPasswordCopyWith(
          _$_NewPassword value, $Res Function(_$_NewPassword) then) =
      __$$_NewPasswordCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$_NewPasswordCopyWithImpl<$Res>
    extends _$NewPasswordCopyWithImpl<$Res, _$_NewPassword>
    implements _$$_NewPasswordCopyWith<$Res> {
  __$$_NewPasswordCopyWithImpl(
      _$_NewPassword _value, $Res Function(_$_NewPassword) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$_NewPassword(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_NewPassword implements _NewPassword {
  const _$_NewPassword(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'NewPassword(email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewPassword &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewPasswordCopyWith<_$_NewPassword> get copyWith =>
      __$$_NewPasswordCopyWithImpl<_$_NewPassword>(this, _$identity);
}

abstract class _NewPassword implements NewPassword {
  const factory _NewPassword(final String email) = _$_NewPassword;

  @override
  String get email;
  @override
  @JsonKey(ignore: true)
  _$$_NewPasswordCopyWith<_$_NewPassword> get copyWith =>
      throw _privateConstructorUsedError;
}
