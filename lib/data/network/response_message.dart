import 'package:city_guide/presentation/ressource/string_manager.dart';

class ResponseMessage {
  // API status code -----------------------------------------------------------
  static const String SUCCESS = AppString.successTitle;
  static const String NO_CONTENT = AppString.noContent;
  static const String BAD_REQUEST = AppString.badRequestError;
  static const String FORBIDDEN = AppString.forbiddenError;
  static const String UNAUTHORIZED = AppString.unauthorizedError;
  static const String NOT_FOUND = AppString.notFoundError;
  static const String INTERNAL_SERVER_ERROR = AppString.internalServerError;

  // Local status code ---------------------------------------------------------
  static const String DEFAULT = AppString.defaultError;
  static const String CONNECT_TIMEOUT = AppString.timeoutError;
  static const String CANCEL = AppString.defaultError;
  static const String RECEIVE_TIMEOUT = AppString.timeoutError;
  static const String SEND_TIMEOUT = AppString.timeoutError;
  static const String CACHE_ERROR = AppString.cacheError;
  static const String NO_INTERNET_CONNECTION = AppString.noInternetError;
}