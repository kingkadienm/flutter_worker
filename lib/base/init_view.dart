import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_worker/base/root_view.dart';
import 'package:flutter_worker/login/manager/login_manager.dart';
import 'package:flutter_worker/login/views/login_view.dart';

class InitView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 360, height: 640)..init(context);

    if (LoginManager().isLogin == false) {
      return LoginView();
    }

    return RootView();
  }
}