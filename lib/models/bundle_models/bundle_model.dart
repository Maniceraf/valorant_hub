import 'package:json_annotation/json_annotation.dart';

part 'bundle_model.g.dart';

@JsonSerializable()
class BundleListResponseModel {
  final int status;
  final List<BundleModel> data;

  BundleListResponseModel({required this.status, required this.data});

  factory BundleListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BundleListResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$BundleListResponseModelToJson(this);
}

@JsonSerializable()
class BundleModel {
  final String uuid;
  final String displayName;
  final String displayIcon;
  final String displayIcon2;

  BundleModel({
    required this.uuid,
    required this.displayName,
    required this.displayIcon,
    required this.displayIcon2,
  });

  factory BundleModel.fromJson(Map<String, dynamic> json) =>
      _$BundleModelFromJson(json);
  Map<String, dynamic> toJson() => _$BundleModelToJson(this);
}
