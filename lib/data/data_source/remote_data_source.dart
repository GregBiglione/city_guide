import 'package:city_guide/data/request/login_request.dart';

import '../response/response.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}