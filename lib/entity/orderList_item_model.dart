import 'package:flutter_worker/entity/serviceInfo_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orderList_item_model.g.dart';

@JsonSerializable(nullable: false)
class OrderListItemModel {

  /*
   * ordernum : 1108368307968413696
   * workOrderCode : 1108368307968413698-1-2
   * type : 0
   * lng : 114.319942
   * lat : 30.532301
   * address : 北京站
   * date : 1553239282000
   * status : 13
   * num : null
   * name : 测试
   * unit : null
   * serverInfo :
   * mobile : 13026622234
   * skuId : 33
   * detailVo : [{"skuName":"踢脚线安装","num":1,"unit":"延米","spuName":"装饰建材安装"}]
   * userName : 佩奇
   * callStatus : null
   * callinfo : null
   */

  String ordernum;
  String workOrderCode;
  String type;
  String lng;
  String lat;
  String address;
  int date;
  int status;
  int num;
  String name;
  String unit;
  String serverInfo;
  String mobile;
  String skuId;
  String userName;
  int callStatus;
  String callinfo;
  List<ServiceInfoModel> detailVo;


  OrderListItemModel({
      this.ordernum,
      this.workOrderCode,
      this.type,
      this.lng,
      this.lat,
      this.address,
      this.date,
      this.status,
      this.num,
      this.name,
      this.unit,
      this.serverInfo,
      this.mobile,
      this.skuId,
      this.userName,
      this.callStatus,
      this.callinfo,
      this.detailVo
  });

  factory OrderListItemModel.fromJson(Map<String, dynamic> json) => _$OrderListItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderListItemModelToJson(this);
}