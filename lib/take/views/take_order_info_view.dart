import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TakeOrderInfoView extends StatelessWidget {
  Widget getView() {
    return Container(
      color: Color(0xfff1f3f7),
      height: ScreenUtil.getInstance().setHeight(1),
      margin: EdgeInsets.only(
          top: ScreenUtil.getInstance().setHeight(12),
          right: ScreenUtil.getInstance().setWidth(16)),
      padding: EdgeInsets.only(
        left: ScreenUtil.getInstance().setWidth(16),
      ),
    );
  }

  Widget getView2(BuildContext context) {
    return Container(
      color: Color(0xfff1f3f7),
      width: MediaQuery.of(context).size.width,
      height: ScreenUtil.getInstance().setHeight(5),
    );
  }

  //订单编号和状态
  Widget getOrderNumWidget(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(16)),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: ScreenUtil().setWidth(13)),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "订单编号:  ----",
                    style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        right: ScreenUtil.getInstance().setWidth(16)),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "订单状态",
                      style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                    ),
                  ),
                )
              ],
            ),
            getView()
          ],
        ));
  }

  //订单信息
  Widget getOrderInfoWidget(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(117),
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          Container(
            height: ScreenUtil.getInstance().setHeight(16),
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              top: ScreenUtil.getInstance().setHeight(16),
              left: ScreenUtil.getInstance().setWidth(16),
            ),
            child: Text(
              "保洁-开荒保洁",
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: ScreenUtil.getInstance().setSp(14)),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            height: ScreenUtil.getInstance().setHeight(16),
            margin: EdgeInsets.only(
                top: ScreenUtil.getInstance().setHeight(15),
                left: ScreenUtil.getInstance().setWidth(16)),
            child: Text(
              "四居及以上210㎡",
              style: TextStyle(
                  color: Color(0x99333333),
                  fontSize: ScreenUtil.getInstance().setSp(14)),
            ),
          ),
          getView(),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            height: ScreenUtil.getInstance().setHeight(16),
            margin: EdgeInsets.only(
                top: ScreenUtil.getInstance().setHeight(15),
                left: ScreenUtil.getInstance().setWidth(16)),
            child: Text(
              "服务时间：10.16（周一） 9:00",
              style: TextStyle(
                  color: Color(0x99333333),
                  fontSize: ScreenUtil.getInstance().setSp(14)),
            ),
          ),
        ],
      ),
    );
  }

  //地址信息
  Widget getOrderAddressWidget() {
    return Container(
      height: ScreenUtil.getInstance().setHeight(93),
      padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(17)),
      margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(16)),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  "陈凤美",
                  style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: ScreenUtil.getInstance().setSp(14)),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil.getInstance().setWidth(26)),
                  child: Text(
                    "181****0093",
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: ScreenUtil.getInstance().setSp(14)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: ScreenUtil.getInstance().setHeight(5),
                right: ScreenUtil.getInstance().setWidth(23)),
            child: Text(
              "北京北京市海淀区中关村街道双宜数东里3号楼友谊鲜果（菜鸟驿站:13423475456）",
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(14),
                  color: Color(0x99333333)),
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }

  //附加费
  Widget getSurchargeWidget() {
    return GestureDetector(
      child: Container(
        height: ScreenUtil.getInstance().setHeight(47),
        margin: EdgeInsets.only(
          left: ScreenUtil.getInstance().setWidth(16),
          right: ScreenUtil.getInstance().setWidth(16),
        ),
        child: Row(
          children: <Widget>[
            Container(
              child: Expanded(
                  child: Text(
                "添加附加费 ",
                style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: ScreenUtil.getInstance().setSp(14)),
              )),
            ),
            Expanded(
                child: Container(
                    alignment: Alignment.centerRight,
                    child: Image.asset('images/order/com_icon_enter.png')))
          ],
        ),
      ),
      onTap: () {
        print("附加费");
      },
    );
  }

  //附加费item
  Widget getSurchargeItemWidget(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
            margin:
                EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(16)),
            child: Text(
              "aaaa",
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: ScreenUtil.getInstance().setSp(14)),
            ),
          )),
          Expanded(
              child: Container(
            margin:
                EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(16)),
            alignment: Alignment.centerRight,
            child: Text(
              "asdd",
              style: TextStyle(
                  color: Color(0xffff3b30),
                  fontSize: ScreenUtil.getInstance().setSp(14)),
            ),
          ))
        ],
      ),
    );
  }

  //附加费列表
  Widget getSurchargeListWidget(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            left: ScreenUtil.getInstance().setWidth(16),
            top: ScreenUtil.getInstance().setHeight(16)),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              child: Text(
                "附加费",
                style: TextStyle(
                    color: Color(0x99333333),
                    fontSize: ScreenUtil.getInstance().setSp(14)),
              ),
            ),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, item) {
                return getSurchargeItemWidget(context);
              },
            ) //设置高度自适应
          ],
        ));
  }

  //总价
  Widget getPriceWidget() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(
          right: ScreenUtil.getInstance().setWidth(16),
          top: ScreenUtil.getInstance().setHeight(17),
          bottom: ScreenUtil.getInstance().setHeight(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "总价",
            style: TextStyle(
                color: Color(0x99333333),
                fontSize: ScreenUtil.getInstance().setSp(14)),
          ),
          Text(
            "￥260",
            style: TextStyle(
                color: Color(0xffff3b30),
                fontSize: ScreenUtil.getInstance().setSp(14)),
          )
        ],
      ),
    );
  }

  //问题回执按钮
  Widget getReceiptButton() {
    return Container(
        margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(15)),
        child: FlatButton(
          textColor: Color(0xff2172f6),
          child: Text(
            "问题回执",
            style: TextStyle(
              fontSize: ScreenUtil.getInstance().setSp(12),
            ),
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color(0xff2172f6),
              width: 1,
            ),
            borderRadius:
                BorderRadius.circular(ScreenUtil.getInstance().setHeight(12)),
          ),
          onPressed: () {
            print("add");
          },
        ));
  }

  //联系客服按钮
  Widget getServiceButton() {
    return Container(
        margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(15)),
        child: FlatButton(
          textColor: Color(0xff2172f6),
          child: Text(
            "联系客服",
            style: TextStyle(
              fontSize: ScreenUtil.getInstance().setSp(12),
            ),
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color(0xff2172f6),
              width: 1,
            ),
            borderRadius:
                BorderRadius.circular(ScreenUtil.getInstance().setHeight(12)),
          ),
          onPressed: () {
            print("add");
          },
        ));
  }

  //开始服务按钮
  Widget getStateServiceButton() {
    return Container(
        margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(15)),
        child: FlatButton(
          textColor: Color(0xffffffff),
          color: Color(0xff2172f6),
          child: Text(
            "开始服务",
            style: TextStyle(
              fontSize: ScreenUtil.getInstance().setSp(12),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(ScreenUtil.getInstance().setHeight(12)),
          ),
          onPressed: () {
            print("add");
          },
        ));
  }

  //底部按钮
  Widget getBoottomButton() {
    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtil.getInstance().setHeight(13),
          bottom: ScreenUtil.getInstance().setHeight(13)),
      height: ScreenUtil.getInstance().setHeight(24),
      child: Row(
        children: <Widget>[
          getReceiptButton(),
          getServiceButton(),
          getStateServiceButton()
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.all(0),
              sliver: new SliverList(
                delegate: new SliverChildListDelegate(<Widget>[
                  getOrderNumWidget(context),
                  getOrderInfoWidget(context),
                  getView2(context),
                  getOrderAddressWidget(),
                  getView2(context),
                  getSurchargeWidget(),
                  getView2(context),
                  getSurchargeListWidget(context),
                  getView(),
                  getPriceWidget(),
                  getView2(context),
                  getBoottomButton()
                ]),
              ),
            ),
          ],
        ));
  }
}
