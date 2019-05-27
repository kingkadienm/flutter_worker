import 'package:json_annotation/json_annotation.dart';

part 'serviceInfo_model.g.dart';

@JsonSerializable(nullable: false)
class ServiceInfoModel {
  String skuName;
  int num;
  String unit;
  String spuName;

  ServiceInfoModel({this.skuName, this.num, this.unit, this.spuName});

  factory ServiceInfoModel.fromJson(Map<String, dynamic> json) => _$ServiceInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceInfoModelToJson(this);
}