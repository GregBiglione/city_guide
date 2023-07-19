import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'network_info.dart';

class NetworkInfoImplementer implements NetworkInfo {
  final InternetConnectionChecker _internetConnectionChecker;

  NetworkInfoImplementer(this._internetConnectionChecker);

  @override
  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;
}