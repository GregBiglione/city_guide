import 'package:city_guide/domain/model/banner.dart';
import 'package:city_guide/domain/model/service.dart';
import 'package:city_guide/domain/model/store.dart';

class HomeData {
  List<Service> services;
  List<Store> stores;
  List<Banner> banners;

  HomeData(this.services, this.stores, this.banners);
}