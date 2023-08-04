import 'package:city_guide/data/data_source/remote_data_source.dart';
import 'package:city_guide/data/request/login_request.dart';
import 'package:city_guide/data/request/register_request.dart';
import 'package:city_guide/data/response/forgot_password_response.dart';
import 'package:city_guide/data/response/response.dart';

import '../network/app_api.dart';

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
      loginRequest.username,
      loginRequest.password,
      "",
      "",
    );
  }

  @override
  Future<ForgotPasswordResponse> newPassword(String email) async {
    return await _appServiceClient.newPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
      registerRequest.countryMobileCode,
      registerRequest.username,
      registerRequest.email,
      registerRequest.password,
      registerRequest.mobileNumber,
      "",
    );
  }
}