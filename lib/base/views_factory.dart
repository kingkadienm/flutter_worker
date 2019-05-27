import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ESWidgetFacotry {

  /* 获取通用脚手架 */
  static Widget scaffold({@required Widget body, Widget appBar, String title}) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: appBar ?? CupertinoNavigationBar(
          middle: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0
            ),
          ),
        ),
        child: body,
      );
    }

    return Scaffold(
      appBar: appBar ?? AppBar(
          title: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0
            ),
          )
      ),
      body: body,
    );
  }


  static Widget addWillPopScope({@required Widget child, @required BuildContext context}) {
    return WillPopScope(
      onWillPop: () {
        return _doubleClickBack(context);
      },
      child: child,
    );
  }

  static int _last = 0;
  static Future<bool> _doubleClickBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      return Future.value(true);
    }

    int now = DateTime.now().millisecondsSinceEpoch;

    if (now - _last > 1000) {
      _last = DateTime.now().millisecondsSinceEpoch;

      Fluttertoast.showToast(
          msg: "再按一次退出程序",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT
      );

      return Future.value(false);
    } else {
      Fluttertoast.cancel();
      return Future.value(true);
    }
  }
}