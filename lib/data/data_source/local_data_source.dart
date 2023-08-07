import '../response/home_response.dart';

abstract class LocalDataSource {
  Future<HomeResponse> getHome();
}