import 'package:city_guide/data/network/error_data_source.dart';
import 'package:city_guide/data/network/error_handler.dart';
import 'package:city_guide/data/response/home_response.dart';

import 'cached_item.dart';
import 'local_data_source.dart';

const String CACHE_HOME_KEY = "CACHE_HOME_KEY";
const int CACHE_HOME_INTERVAL = 60 * 1000; // 1' en ms

class LocalDataSourceImplementer implements LocalDataSource {
  // Run time cache ------------------------------------------------------------
  Map<String, CachedItem> cacheMap = Map();


  @override
  Future<HomeResponse> getHome() async {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];

    if(cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      // Return response from cache --------------------------------------------
      return cachedItem.data;
    }
    else {
      // Return error that cache isn't valid -----------------------------------
      throw ErrorHandler.handle(ErrorDataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}