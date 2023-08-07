import 'package:city_guide/data/response/home_response.dart';

import 'cached_item.dart';
import 'local_data_source.dart';

const String CACHE_HOME_KEY = "CACHE_HOME_KEY";

class LocalDataSourceImplementer implements LocalDataSource {
  // Run time cache ------------------------------------------------------------
  Map<String, CachedItem> cacheMap = Map();


  @override
  Future<HomeResponse> getHome() async {
    // TODO: implement getHome
    throw UnimplementedError();
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }
}