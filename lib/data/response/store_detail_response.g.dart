// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreDetailResponse _$StoreDetailResponseFromJson(Map<String, dynamic> json) =>
    StoreDetailResponse(
      json['image'] as String?,
      json['id'] as int?,
      json['title'] as int?,
      json['details'] as int?,
      json['services'] as int?,
      json['about'] as int?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$StoreDetailResponseToJson(
        StoreDetailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'image': instance.image,
      'id': instance.id,
      'title': instance.title,
      'details': instance.details,
      'services': instance.services,
      'about': instance.about,
    };
