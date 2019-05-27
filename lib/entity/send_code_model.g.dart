// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendCodeModel _$SendCodeModelFromJson(Map<String, dynamic> json) {
  return SendCodeModel(json['data'] as String, json['errorInfo'] as String,
      json['statusCode'] as int);
}

Map<String, dynamic> _$SendCodeModelToJson(SendCodeModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorInfo': instance.errorInfo,
      'statusCode': instance.statusCode
    };
