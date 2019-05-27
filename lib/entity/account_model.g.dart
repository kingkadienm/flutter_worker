// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) {
  return AccountModel(
      jrwyToken: json['jrwyToken'] as String,
      name: json['name'] as String,
      userid: json['userid'] as int,
      technicianId: json['technicianId'] as int);
}

Map<String, dynamic> _$AccountModelToJson(AccountModel instance) =>
    <String, dynamic>{
      'jrwyToken': instance.jrwyToken,
      'name': instance.name,
      'userid': instance.userid,
      'technicianId': instance.technicianId
    };
