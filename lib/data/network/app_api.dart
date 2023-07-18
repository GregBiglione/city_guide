import 'package:city_guide/app/constant.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../response/response.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
  
  @POST("/customers/login")
  Future<AuthenticationResponse> login();
}