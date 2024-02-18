// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgentListItemModel _$AgentListItemModelFromJson(Map<String, dynamic> json) =>
    AgentListItemModel(
      uuid: json['uuid'] as String,
      displayName: json['displayName'] as String,
      displayIcon: json['displayIcon'] as String,
      role: Role.fromJson(json['role'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AgentListItemModelToJson(AgentListItemModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'displayName': instance.displayName,
      'displayIcon': instance.displayIcon,
      'role': instance.role,
    };

AgentListResponseModel _$AgentListResponseModelFromJson(
        Map<String, dynamic> json) =>
    AgentListResponseModel(
      status: json['status'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => AgentListItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AgentListResponseModelToJson(
        AgentListResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

AgentModel _$AgentModelFromJson(Map<String, dynamic> json) => AgentModel(
      uuid: json['uuid'] as String,
      displayName: json['displayName'] as String,
      description: json['description'] as String,
      displayIcon: json['displayIcon'] as String,
      fullPortrait: json['fullPortrait'] as String,
      killfeedPortrait: json['killfeedPortrait'] as String,
      background: json['background'] as String,
      role: Role.fromJson(json['role'] as Map<String, dynamic>),
      abilities: (json['abilities'] as List<dynamic>)
          .map((e) => Ability.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AgentModelToJson(AgentModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'displayName': instance.displayName,
      'description': instance.description,
      'displayIcon': instance.displayIcon,
      'fullPortrait': instance.fullPortrait,
      'killfeedPortrait': instance.killfeedPortrait,
      'background': instance.background,
      'role': instance.role,
      'abilities': instance.abilities,
    };

AgentResponseModel _$AgentResponseModelFromJson(Map<String, dynamic> json) =>
    AgentResponseModel(
      status: json['status'] as int,
      data: AgentModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AgentResponseModelToJson(AgentResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
