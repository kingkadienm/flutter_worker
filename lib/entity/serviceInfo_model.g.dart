// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serviceInfo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceInfoModel _$ServiceInfoModelFromJson(Map<String, dynamic> json) {
  return ServiceInfoModel(
      skuName: json['skuName'] as String,
      num: json['num'] as int,
      unit: json['unit'] as String,
      spuName: json['spuName'] as String);
}

Map<String, dynamic> _$ServiceInfoModelToJson(ServiceInfoModel instance) =>
    <String, dynamic>{
      'skuName': instance.skuName,
      'num': instance.num,
      'unit': instance.unit,
      'spuName': instance.spuName
    };
