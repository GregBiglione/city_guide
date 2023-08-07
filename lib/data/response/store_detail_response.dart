import 'package:city_guide/data/response/response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store_detail_response.g.dart';

@JsonSerializable()
class StoreDetailResponse extends BaseResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "details")
  String? details;
  @JsonKey(name: "services")
  String? services;
  @JsonKey(name: "about")
  String? about;

  StoreDetailResponse(this.id, this.image, this.title, this.details,
      this.services, this.about);
  
  factory StoreDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDetailResponseToJson(this);
}