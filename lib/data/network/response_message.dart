class ResponseMessage {
  // API status code -----------------------------------------------------------
  static const String SUCCESS = "Success";
  static const String NO_CONTENT = "Success with no content";
  static const String BAD_REQUEST = "Bad request, try again later";
  static const String FORBIDDEN = "Forbidden request, try again later";
  static const String UNAUTHORIZED = "User in unauthorized, try again later";
  static const String NOT_FOUND = "Url not found, try again later";
  static const String StringERNAL_SERVER_ERROR = "Something went wrong, try again later";

  // Local status code ---------------------------------------------------------
  static const String UNKNOWN = "Something went wrong, try again later";
  static const String CONNECT_TIMEOUT = "Timeout error, try again later";
  static const String CANCEL = "Request was cancelled, try again later";
  static const String RECEIVE_TIMEOUT = "Timeout error, try again later";
  static const String SEND_TIMEOUT = "Timeout error, try again later";
  static const String CACHE_ERROR = "Cache error, try again later";
  static const String NO_INTERNET_CONNECTION = "Please check your internet connection";
}