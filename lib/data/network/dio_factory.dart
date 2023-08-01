import 'package:city_guide/app/app_preferences.dart';
import 'package:city_guide/app/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'dart:convert';

import 'json_converter.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();
    Duration timeOut = const Duration(seconds: 60);
    String language = await _appPreferences.getApplicationLanguage();

    Map<String, String> header = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constant.token,
      DEFAULT_LANGUAGE: language,
    };

    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
      headers: header,
    );

    if(kReleaseMode) {
      print("Release mode no logs");
    }
    else {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
      dio.interceptors.add(JsonResponseConverter());
    }

    return dio;
  }
}