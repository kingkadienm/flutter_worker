import 'package:flutter/material.dart';
import 'package:flutter_worker/api/order_api.dart';
import 'package:flutter_worker/base/views_factory.dart';
import 'package:flutter_worker/entity/orderList_item_model.dart';
import 'package:flutter_worker/login/manager/login_manager.dart';
import 'package:flutter_worker/network/network_manager.dart';
import 'package:flutter_worker/take/views/take_orderList_item_view.dart';
import 'package:flutter_worker/utils/native_utils.dart';
import 'package:flutter_worker/utils/progressHud.dart';
import 'dart:async';
class TakeOrderListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TakeOrderState();
  }
}

class _TakeOrderState extends State<TakeOrderListView>
    with NetworkManagerDelegate {

  bool _loading = true;
  List<OrderListItemModel> items = [];

  @override
  void initState() {
    super.initState();
    //NetworkManager.addDelegate(this);
    print("take list initstate");
   _getMacAddr();
    _requestData();
  }

  _getMacAddr() async {
    String mac = await NativeUtils.getMacAddress();
    print(mac);
  }

  _requestData() async {
    setState(() {
      _loading = true;
    });
    try {
      var result = await OrderApi.getOrderList(status: OrderStatus.toTake);
      items = result;
      setState(() {
        _loading = false;
      });
    } on NetworkError catch (e) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    //NetworkManager.removeDelegate(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ESWidgetFacotry.scaffold(
        body: Stack(
          children: <Widget>[
            _buildBody(),
            ProgressHud(loading: _loading)
          ],
        ),
        title: '接单'
    );
  }

  Widget _buildBody() {
    return Container(
      color: Color(0xFFF1F3F7),
      child: ListView.builder(
          padding: EdgeInsets.only(bottom: 10),
          itemCount: items.length,
          itemBuilder: (context, index) {

            var item = items[index];
            return TakeOrderListItemView(
                index: index,
                listItem: item,
                takeOrder: (index) {
                  print(index);
//                  LoginManager.alertAndLogin('爸爸八九十代理费');
                  addIndicator(this.context);
                },
                openDetail: (index) {
//                  RouterUtils.openOrderDetail(GlobalUtils().rootContext);
                LoginManager.doLogout();
                });
          }),
    );
  }

  @override
  networkReconnect() {
    _requestData();
  }
  
  addIndicator(BuildContext c) {
//    showGeneralDialog(context: null, pageBuilder: null)

    setState(() {
      _loading = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _loading = false;
      });
    });
  }
}


