// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreDetailResponse _$StoreDetailResponseFromJson(Map<String, dynamic> json) =>
    StoreDetailResponse(
      json['id'] as int?,
      json['image'] as String?,
      json['title'] as String?,
      json['details'] as String?,
      json['services'] as String?,
      json['about'] as String?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$StoreDetailResponseToJson(
        StoreDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'id': instance.id,
      'image': instance.image,
      'title': instance.title,
      'details': instance.details,
      'services': instance.services,
      'about': instance.about,
    };
