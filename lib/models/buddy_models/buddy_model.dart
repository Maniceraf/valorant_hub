import 'package:json_annotation/json_annotation.dart';

part 'buddy_model.g.dart';

@JsonSerializable()
class BuddyModel {
  final String uuid;
  final String displayName;
  final String displayIcon;

  BuddyModel({
    required this.uuid,
    required this.displayName,
    required this.displayIcon,
  });

  factory BuddyModel.fromJson(Map<String, dynamic> json) =>
      _$BuddyModelFromJson(json);
  Map<String, dynamic> toJson() => _$BuddyModelToJson(this);
}

@JsonSerializable()
class BuddyListResponseModel {
  final int status;
  final List<BuddyModel> data;

  BuddyListResponseModel({required this.status, required this.data});

  factory BuddyListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BuddyListResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$BuddyListResponseModelToJson(this);
}
