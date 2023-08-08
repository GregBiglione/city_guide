import 'package:city_guide/data/response/store_detail_response.dart';

import '../response/home_response.dart';

abstract class LocalDataSource {
  Future<HomeResponse> getHome();
  Future<void> saveHomeToCache(HomeResponse homeResponse);
  Future<StoreDetailResponse> getStoreDetail();
  Future<void> saveStoreDetailToCache(StoreDetailResponse storeDetailResponse);
  void clearCache();
  void removeFromCache(String key);
}