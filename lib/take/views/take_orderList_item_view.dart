import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_worker/entity/orderList_item_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_worker/utils/time_utils.dart';

typedef TakeOrderListItemViewCallback = void Function(int index);

class TakeOrderListItemView extends StatelessWidget {
  TakeOrderListItemView({
    Key key,
    @required this.index,
    @required this.listItem,
    @required this.takeOrder,
    @required this.openDetail,
  }) : super(key: key);

  final OrderListItemModel listItem;
  final int index;
  final TakeOrderListItemViewCallback takeOrder;
  final TakeOrderListItemViewCallback openDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: ScreenUtil.getInstance().setWidth(158),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[getOrderNumWidget(), getInfoWidget()],
      ),
    );
  }

  /*订单编号*/
  Widget getOrderNumWidget() {
    return Container(
      height: ScreenUtil.getInstance().setWidth(33),
      padding: EdgeInsets.only(
          left: ScreenUtil.getInstance().setWidth(16),
          top: ScreenUtil().setWidth(9)),
      child: Text(
        "订单编号:  ${listItem.workOrderCode ?? '--'}",
        style: TextStyle(fontSize: 12, color: Color(0xFF333333)),
      ),
    );
  }

  /*订单信息*/
  Widget getInfoWidget() {
    return Container(
      height: ScreenUtil.getInstance().setWidth(125),
      padding: EdgeInsets.only(
          left: ScreenUtil.getInstance().setWidth(16),
          right: ScreenUtil.getInstance().setWidth(16)),
      child: Row(
        children: <Widget>[
          Container(
            color: Colors.white,
            width: ScreenUtil.getInstance().setWidth(290),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 44,
                  child: getInfoDateWidget(),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil.getInstance().setWidth(7)),
                    height: 1,
                    color: Color(0xFFE7E8E7),
                  ),
                ),
                Expanded(
                  flex: 80,
                  child: GestureDetector(
                    onTap: () {
                      openDetail(index);
                    },
                    child: getInfoDetailWidget(),
                  ),
                )
              ],
            ),
          ),
          getOrderTakeWidget()
        ],
      ),
    );
  }

  /*订单日期*/
  Widget getInfoDateWidget() {
    var time = TimeUtils.stampToStr(listItem.date);
    return Container(
      height: ScreenUtil.getInstance().setWidth(45),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil.getInstance().setWidth(7.5),
                right: ScreenUtil.getInstance().setWidth(9)),
            child: SizedBox(
                width: ScreenUtil.getInstance().setWidth(20),
                height: ScreenUtil.getInstance().setWidth(20),
                child: Image.asset('images/order/order_info_date.png')),
          ),
          Expanded(
            child: Text(
              '${time}',
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: ScreenUtil.getInstance().setSp(14)),
            ),
          )
        ],
      ),
    );
  }

  Widget getInfoDetailWidget() {
    String infoDetail;
    if (listItem.detailVo.length > 0) {
      infoDetail = listItem.detailVo[0].spuName;
    }
    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 27,
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: ScreenUtil.getInstance().setWidth(7.5),
                              right: ScreenUtil.getInstance().setWidth(9)),
                          child: SizedBox(
                              width: ScreenUtil.getInstance().setWidth(20),
                              height: ScreenUtil.getInstance().setWidth(20),
                              child: Image.asset(
                                  'images/order/order_info_address.png')),
                        ),
                        Expanded(
                          child: Text(
                            '${listItem.address}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: ScreenUtil.getInstance().setSp(14)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: ScreenUtil.getInstance().setWidth(7.5),
                              right: ScreenUtil.getInstance().setWidth(9)),
                          child: SizedBox(
                              width: ScreenUtil.getInstance().setWidth(20),
                              height: ScreenUtil.getInstance().setWidth(20),
                              child: Image.asset(
                                  'images/order/order_info_detail.png')),
                        ),
                        Expanded(
                            child: Text(
                          '${infoDetail ?? "--"}',
                          style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: ScreenUtil.getInstance().setSp(14)),
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Image.asset("images/order/order_info_arrow.png"),
            ),
          ),
        ],
      ),
    );
  }

  /*接单按钮*/
  Widget getOrderTakeWidget() {
    return GestureDetector(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(38),
        height: ScreenUtil.getInstance().setWidth(115),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Image.asset('images/order/order_take_back.png',
                colorBlendMode: BlendMode.srcIn),
            Text(
              '接单',
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(14),
                  color: Color(0xFFFDFEFF)),
            )
          ],
        ),
      ),
      onTap: () {
        takeOrder(index);
      },
    );
  }
}
