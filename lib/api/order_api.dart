import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_worker/login/manager/login_manager.dart';
import 'package:flutter_worker/network/network_manager.dart';
import 'package:flutter_worker/entity/orderList_item_model.dart';

enum OrderStatus {
  toTake,
  toServe,
  serving,
  finish
}

class OrderApi {

  /*
  *   获取订单列表
  *   接单、待服务、服务中、服务完成
  */
  static Future<List<OrderListItemModel>> getOrderList({
    @required OrderStatus status
  }) async {
    var url = '/order/worker/listH5';

    int statusCode;

    switch (status) {
      case OrderStatus.toTake:
        statusCode = 14;
        break;
      case OrderStatus.toServe:
        statusCode = 15;
        break;
      case OrderStatus.serving:
        statusCode = 16;
        break;
      case OrderStatus.finish:
        statusCode = 18;
        break;
    }

    Response response = await NetworkManager.request(
      method: RequestMethod.post,
      url: url,
      data: {'status': statusCode, 'userId': LoginManager().currentUser.technicianId},
    );

    var result = response.data['data'] as List;

    if (result != null) {
      var list = result.map((i) => OrderListItemModel.fromJson(i as Map<String, dynamic>)).toList() ;
      return list;
    }
    throw NetworkError(NetworkErrorType.custom, '格式错误');
  }
}
