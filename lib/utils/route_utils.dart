import 'package:flutter/material.dart';
import 'package:flutter_worker/base/views_factory.dart';
import 'package:flutter_worker/take/views/take_order_info_view.dart';

class RouterUtils {
  static openOrderDetail(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (c) {
      return ESWidgetFacotry.scaffold(
          body: ESWidgetFacotry.addWillPopScope(
              child: Container(
                child: TakeOrderInfoView(),
              ),
              context: context),
          title: "服务详情");
    }));
  }
}
