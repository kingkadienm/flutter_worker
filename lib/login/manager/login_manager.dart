import 'dart:io';

import 'package:flutter_worker/entity/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_worker/utils/const_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_worker/login/views/login_view.dart';
import 'package:flutter_worker/utils/global_utils.dart';
import 'package:flutter_worker/base/root_view.dart';

abstract class LoginManagerDelegate {
  onLogin() {}

  onLogout() {}
}

class LoginManager {
  factory LoginManager() => _sharedInstance();
  bool isLogin;
  AccountModel currentUser;

  static Future start() async {
    await LoginManager()._getLoginStatus();
    return;
  }

  static addLoginDelegate(LoginManagerDelegate delegate) {
    if (!LoginManager().delegates.contains(delegate)) {
      LoginManager().delegates.add(delegate);
    }
  }

  static removeLoginDelegate(LoginManagerDelegate delegate) {
    if (LoginManager().delegates.contains(delegate)) {
      LoginManager().delegates.remove(delegate);
    }
  }

  static doLogin() {
    BuildContext rootContext = GlobalUtils().rootContext;

    Navigator.pushReplacement(
        rootContext,
        PageRouteBuilder(pageBuilder: (context, _, __) {
          return LoginView();
        }, transitionsBuilder:
            (_, Animation<double> animation, __, Widget child) {
          return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                  alignment: Alignment.bottomCenter,
                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
                  child: child));
        }));
  }

  static loginComplete(BuildContext context) {
    LoginManager()._setStatus(true);
    LoginManager()._setLoginStatus(true);
    for (var delegate in LoginManager().delegates) {
      delegate.onLogin();
    }

    Navigator.pushReplacement(
        context,
        PageRouteBuilder(pageBuilder: (context, _, __) {
          return RootView();
        }, transitionsBuilder:
            (_, Animation<double> animation, __, Widget child) {
          return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                  alignment: Alignment.bottomCenter,
                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
                  child: child));
        }));
  }

  static doLogout() {
    LoginManager().currentUser = null;
    LoginManager()._setStatus(false);
    LoginManager()._setLoginStatus(false);
    for (var delegate in LoginManager().delegates) {
      delegate.onLogout();
    }
    doLogin();
  }

  static alertAndLogin(String content) async {
    if (GlobalUtils().rootContext != null) {
      if (Platform.isIOS) {
        showCupertinoDialog(
            context: GlobalUtils().rootContext,
            builder: (context) {
              return CupertinoAlertDialog(
                  title: Text('提示'),
                  content: Text('${content}'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text('重新登录'),
                      onPressed: () {
                        doLogin();
                      },
                    )
                  ]);
            });
      } else {
        showDialog(
            barrierDismissible: false,
            context: GlobalUtils().rootContext,
            builder: (context) {
              return AlertDialog(
                title: Text('提示'),
                content: Text('${content}'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('重新登录'),
                    onPressed: () {
                      doLogin();
                    },
                  )
                ],
              );
            });
      }
    }
  }

  /* private */
  LoginManager._();

  static LoginManager _instance;

  Set<LoginManagerDelegate> delegates = Set<LoginManagerDelegate>();

  static LoginManager _sharedInstance() {
    if (_instance == null) {
      _instance = LoginManager._();
    }
    return _instance;
  }

  Future _getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool status = prefs.getBool(ConstUtils.isLoginFlag);
    isLogin = status;
    if (status == null) {
      isLogin = false;
      prefs.setBool(ConstUtils.isLoginFlag, false);
    }

    currentUser = AccountModel();
    currentUser.jrwyToken = prefs.getString(ConstUtils.currentUserJRWYTokenFlag);
    currentUser.name = prefs.getString(ConstUtils.currentUserNameFlag);
    currentUser.userid = prefs.getInt(ConstUtils.currentUserIdFlag);
    currentUser.technicianId = prefs.getInt(ConstUtils.currentTechnicianIdFlag);
    return;
  }

  Future _setLoginStatus(bool isLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(ConstUtils.isLoginFlag, isLogin);

    if (currentUser != null) {
      prefs.setString(ConstUtils.currentUserJRWYTokenFlag, currentUser.jrwyToken);
      prefs.setString(ConstUtils.currentUserNameFlag, currentUser.name);
      prefs.setInt(ConstUtils.currentUserIdFlag, currentUser.userid);
      prefs.setInt(ConstUtils.currentTechnicianIdFlag, currentUser.technicianId);
    } else {
      prefs.remove(ConstUtils.currentUserJRWYTokenFlag);
      prefs.remove(ConstUtils.currentUserNameFlag);
      prefs.remove(ConstUtils.currentUserIdFlag);
      prefs.remove(ConstUtils.currentTechnicianIdFlag);
    }
    return;
  }

  _setStatus(bool status) {
    if (_instance.isLogin != status) {
      _instance.isLogin = status;
    }
  }
}
