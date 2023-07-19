import 'package:city_guide/data/data_source/remote_data_source.dart';
import 'package:city_guide/data/request/login_request.dart';
import 'package:city_guide/data/response/response.dart';

import '../network/app_api.dart';

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) {
    return _appServiceClient.login(
      loginRequest.username,
      loginRequest.password,
      loginRequest.imei,
      loginRequest.deviceType,
    );
  }
}