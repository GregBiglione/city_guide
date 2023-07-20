import 'package:city_guide/data/network/error_data_source.dart';
import 'package:city_guide/data/network/error_data_source_extension.dart';
import 'package:city_guide/data/network/failure.dart';
import 'package:city_guide/data/network/response_code.dart';
import 'package:dio/dio.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic exception) {
    if(exception is DioException) {
      // Error from response ---------------------------------------------------
      failure = _handleError(exception);
    }
    else {
      // Default error ---------------------------------------------------------
      failure = ErrorDataSource.DEFAULT.getFailure();
    }
  }

  Failure _handleError(DioException exception) {
    switch(exception.type) {
      case DioExceptionType.connectionTimeout:
        return ErrorDataSource.CONNECT_TIMEOUT.getFailure();
      case DioExceptionType.sendTimeout:
        return ErrorDataSource.SEND_TIMEOUT.getFailure();
      case DioExceptionType.receiveTimeout:
        return ErrorDataSource.RECEIVE_TIMEOUT.getFailure();
      case DioExceptionType.badCertificate:
        return ErrorDataSource.BAD_REQUEST.getFailure();
      case DioExceptionType.badResponse:
        switch(exception.response?.statusCode) {
          case ResponseCode.BAD_REQUEST:
            return ErrorDataSource.BAD_REQUEST.getFailure();
          case ResponseCode.FORBIDDEN:
            return ErrorDataSource.FORBIDDEN.getFailure();
          case ResponseCode.UNAUTHORIZED:
            return ErrorDataSource.UNAUTHORIZED.getFailure();
          case ResponseCode.NOT_FOUND:
            return ErrorDataSource.NOT_FOUND.getFailure();
          case ResponseCode.INTERNAL_SERVER_ERROR:
            return ErrorDataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return ErrorDataSource.DEFAULT.getFailure();
        }
      case DioExceptionType.cancel:
        return ErrorDataSource.CANCEL.getFailure();
      case DioExceptionType.connectionError:
        return ErrorDataSource.CONNECT_TIMEOUT.getFailure();
      case DioExceptionType.unknown:
        return ErrorDataSource.DEFAULT.getFailure();
    }
  }
}