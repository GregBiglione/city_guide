import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_password.freezed.dart';

@freezed
class NewPassword with _$NewPassword {
  const factory NewPassword(
      String email,
  ) = _NewPassword;
}