// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buddy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuddyModel _$BuddyModelFromJson(Map<String, dynamic> json) => BuddyModel(
      uuid: json['uuid'] as String,
      displayName: json['displayName'] as String,
      displayIcon: json['displayIcon'] as String,
    );

Map<String, dynamic> _$BuddyModelToJson(BuddyModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'displayName': instance.displayName,
      'displayIcon': instance.displayIcon,
    };

BuddyListResponseModel _$BuddyListResponseModelFromJson(
        Map<String, dynamic> json) =>
    BuddyListResponseModel(
      status: json['status'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => BuddyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BuddyListResponseModelToJson(
        BuddyListResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
