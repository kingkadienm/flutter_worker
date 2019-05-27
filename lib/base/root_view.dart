import 'package:flutter/material.dart';
import 'package:flutter_worker/take/views/take_orderList_view.dart';
import 'package:flutter_worker/service/views/service_orderList_view.dart';
import 'package:flutter_worker/mine/views/mine_view.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter_worker/login/manager/login_manager.dart';
import 'package:flutter_worker/utils/global_utils.dart';
import 'package:flutter_worker/base/views_factory.dart';

class RootView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> with LoginManagerDelegate {
  int _tabIndex = 0;
  List tabImages;
  List appBarTitles;
  List<Widget> pageList;
  List<Widget> tabs;
  List<Widget> iOSPageList;

  @override
  void initState() {
    tabImages = [
      [
        getTabImage('images/tab/receive.png'),
        getTabImage('images/tab/receive_selected.png')
      ],
      [
        getTabImage('images/tab/service.png'),
        getTabImage('images/tab/service_selected.png')
      ],
      [
        getTabImage('images/tab/mine.png'),
        getTabImage('images/tab/mine_selected.png')
      ]
    ];
    appBarTitles = ['接单', '服务单', '我的'];
    pageList = [TakeOrderListView(), ServiceOrderListView(), MineView()];

    if (Platform.isIOS) {
      iOSPageList = List<Widget>.generate(pageList.length,
          (int index) => getIOSPageItem(index, pageList[index]));
    } else {
      tabs = List<Widget>(pageList.length);
    }

    super.initState();

    GlobalUtils().rootContext = context;

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabImages?.clear();
    appBarTitles?.clear();
    pageList?.clear();
    iOSPageList?.clear();
  }



  @override
  Widget build(BuildContext context) {

    if (Platform.isIOS) {
      return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            getTabItem(0),
            getTabItem(1),
            getTabItem(2),
          ],
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ),
        tabBuilder: (contex, index) {
          return iOSPageList[index];
        },
      );
    }

    return ESWidgetFacotry.addWillPopScope(
        child: Scaffold(
          resizeToAvoidBottomPadding: false, //输入框抵住键盘 内容不随键盘滚动
          body: getPageItem(context),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            items: [
              getTabItem(0),
              getTabItem(1),
              getTabItem(2),
            ],
            currentIndex: _tabIndex,
            onTap: (index) {
              setState(() {
                _tabIndex = index;
              });
            },
          ),
        ),
        context: context);
  }

  Widget getPageItem(BuildContext context) {
    return Stack(
      children: List<Widget>.generate(3, (int index) {
        if (_tabIndex == index || tabs[index] != null) {
          tabs[index] = pageList[index];
        }
        return Offstage(
          offstage: _tabIndex != index,
          child: TickerMode(
            enabled: _tabIndex == index,
            child: tabs[index] ?? Container(),
          ),
        );
      }),
    );
  }

  CupertinoTabView getIOSPageItem(int index, Widget child) {
    return CupertinoTabView(
      builder: (context) {
        return child;
      },
    );
  }

  BottomNavigationBarItem getTabItem(int index) {
    return BottomNavigationBarItem(
        icon: tabImages[index][0],
        title: getTabTitle(index),
        activeIcon: tabImages[index][1],
        backgroundColor: Colors.white);
  }

  Image getTabImage(path) {
    return Image.asset(path);
  }

  Text getTabTitle(int curIndex) {
    return Text(appBarTitles[curIndex],
        style: TextStyle(
            fontSize: 10.0,
            color:
                curIndex == _tabIndex ? Color(0xFF2977F6) : Color(0xFFE5E5E5)));
  }
}
