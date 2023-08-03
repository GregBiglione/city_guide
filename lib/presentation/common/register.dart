import 'package:freezed_annotation/freezed_annotation.dart';

part 'register.freezed.dart';

@freezed
class Register with _$Register {
  const factory Register(
    String countryMobileCode,
    String username,
    String email,
    String password,
    String mobileNumber,
    String profilePicture,
  ) = _Register;
}