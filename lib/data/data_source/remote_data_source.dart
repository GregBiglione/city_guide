import 'package:city_guide/data/request/login_request.dart';
import 'package:city_guide/data/request/new_password_request.dart';
import 'package:city_guide/data/response/forgot_password_response.dart';

import '../response/response.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> newPassword(String email);
}