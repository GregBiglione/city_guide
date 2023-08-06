import 'package:city_guide/app/constant.dart';
import 'package:city_guide/data/response/home_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../response/forgot_password_response.dart';
import '../response/response.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
  
  @POST("/customers/login")
  Future<AuthenticationResponse> login(
      @Field("username") String username,
      @Field("password") String password,
      @Field("imei") String imei,
      @Field("deviceType") String deviceType,
  );
  
  @POST("/customers/forgotPassword")
  Future<ForgotPasswordResponse> newPassword(
      @Field("email") String email,
  );

  @POST("/customers/register")
  Future<AuthenticationResponse> register(
      @Field("countryMobileCode") String countryMobileCode,
      @Field("username") String username,
      @Field("email") String email,
      @Field("password") String password,
      @Field("mobileNumber") String mobileNumber,
      @Field("profilePicture") String profilePicture,
  );

  @GET("/home")
  Future<HomeResponse> getHome();
}