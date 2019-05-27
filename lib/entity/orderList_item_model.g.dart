// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderList_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderListItemModel _$OrderListItemModelFromJson(Map<String, dynamic> json) {
  return OrderListItemModel(
      ordernum: json['ordernum'] as String,
      workOrderCode: json['workOrderCode'] as String,
      type: json['type'].toString(),
      lng: json['lng'] as String,
      lat: json['lat'] as String,
      address: json['address'] as String,
      date: json['date'] as int,
      status: json['status'] as int,
      num: json['num'] as int,
      name: json['name'] as String,
      unit: json['unit'] as String,
      serverInfo: json['serverInfo'] as String,
      mobile: json['mobile'] as String,
      skuId: json['skuId'] as String,
      userName: json['userName'] as String,
      callStatus: json['callStatus'] as int,
      callinfo: json['callinfo'] as String,
      detailVo: (json['detailVo'] as List)
          .map((e) => ServiceInfoModel.fromJson(e as Map<String, dynamic>))
          .toList());
}

Map<String, dynamic> _$OrderListItemModelToJson(OrderListItemModel instance) =>
    <String, dynamic>{
      'ordernum': instance.ordernum,
      'workOrderCode': instance.workOrderCode,
      'type': instance.type,
      'lng': instance.lng,
      'lat': instance.lat,
      'address': instance.address,
      'date': instance.date,
      'status': instance.status,
      'num': instance.num,
      'name': instance.name,
      'unit': instance.unit,
      'serverInfo': instance.serverInfo,
      'mobile': instance.mobile,
      'skuId': instance.skuId,
      'userName': instance.userName,
      'callStatus': instance.callStatus,
      'callinfo': instance.callinfo,
      'detailVo': instance.detailVo
    };
