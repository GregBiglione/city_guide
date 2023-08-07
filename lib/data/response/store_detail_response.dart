import 'package:city_guide/data/response/response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store_detail_response.g.dart';

@JsonSerializable()
class StoreDetailResponse extends BaseResponse {
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  int? title;
  @JsonKey(name: "details")
  int? details;
  @JsonKey(name: "services")
  int? services;
  @JsonKey(name: "about")
  int? about;

  StoreDetailResponse(this.image, this.id, this.title, this.details, 
      this.services, this.about);
  
  factory StoreDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDetailResponseToJson(this);
}