import 'package:city_guide/data/response/banner_response.dart';
import 'package:city_guide/data/response/service_response.dart';
import 'package:city_guide/data/response/store_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_data_response.g.dart';

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: "services")
  List<ServiceResponse>? services;
  @JsonKey(name: "stores")
  List<StoreResponse>? stores;
  @JsonKey(name: "banners")
  List<BannerResponse>? banners;

  HomeDataResponse(this.services, this.stores, this.banners);

  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);
}