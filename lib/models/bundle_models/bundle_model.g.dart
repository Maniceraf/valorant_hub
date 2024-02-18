// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bundle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BundleListResponseModel _$BundleListResponseModelFromJson(
        Map<String, dynamic> json) =>
    BundleListResponseModel(
      status: json['status'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => BundleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BundleListResponseModelToJson(
        BundleListResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

BundleModel _$BundleModelFromJson(Map<String, dynamic> json) => BundleModel(
      uuid: json['uuid'] as String,
      displayName: json['displayName'] as String,
      displayIcon: json['displayIcon'] as String,
      displayIcon2: json['displayIcon2'] as String,
    );

Map<String, dynamic> _$BundleModelToJson(BundleModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'displayName': instance.displayName,
      'displayIcon': instance.displayIcon,
      'displayIcon2': instance.displayIcon2,
    };
