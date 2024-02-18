import 'package:json_annotation/json_annotation.dart';
import 'package:valorant_hub/models/ability.dart';
import 'package:valorant_hub/models/role.dart';

part 'agent_model.g.dart';

@JsonSerializable()
class AgentListItemModel {
  final String uuid;
  final String displayName;
  final String displayIcon;
  final Role role;

  AgentListItemModel(
      {required this.uuid,
      required this.displayName,
      required this.displayIcon,
      required this.role});

  factory AgentListItemModel.fromJson(Map<String, dynamic> json) =>
      _$AgentListItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$AgentListItemModelToJson(this);
}

@JsonSerializable()
class AgentListResponseModel {
  final int status;
  final List<AgentListItemModel> data;

  AgentListResponseModel({required this.status, required this.data});

  factory AgentListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AgentListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AgentListResponseModelToJson(this);
}

@JsonSerializable()
class AgentModel {
  final String uuid;
  final String displayName;
  final String description;
  final String displayIcon;
  final String fullPortrait;
  final String killfeedPortrait;
  final String background;
  final Role role;
  final List<Ability> abilities;

  AgentModel(
      {required this.uuid,
      required this.displayName,
      required this.description,
      required this.displayIcon,
      required this.fullPortrait,
      required this.killfeedPortrait,
      required this.background,
      required this.role,
      required this.abilities});

  factory AgentModel.fromJson(Map<String, dynamic> json) =>
      _$AgentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AgentModelToJson(this);
}

@JsonSerializable()
class AgentResponseModel {
  final int status;
  final AgentModel data;

  AgentResponseModel({required this.status, required this.data});

  factory AgentResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AgentResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AgentResponseModelToJson(this);
}
