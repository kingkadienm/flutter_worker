import 'package:flutter_worker/login/manager/login_manager.dart';
import 'package:flutter_worker/network/network_manager.dart';

typedef AppStartUtilsCompleteCallBack = void Function();

class AppStartUtils {
  static start(AppStartUtilsCompleteCallBack callBack) {
    _callBack = callBack;

    _initData();
  }

  static _initData() async {
    /* LoginManager */
    await LoginManager.start();
    /* 网络 */
    await NetworkManager.start(
        baseUrl: "https://uat-server.juranguanjia.com/api");

    _callBack();
  }

  static AppStartUtilsCompleteCallBack _callBack;
}
