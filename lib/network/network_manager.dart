import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_worker/login/manager/login_manager.dart';

abstract class NetworkManagerDelegate {
  networkReconnect();
}

enum RequestMethod { get, post, put, delete, head }

enum NetworkErrorType {
  // 网络错误
  network,
  // 服务业务错误
  server,
  // 自定义错误
  custom
}

class NetworkError {
  // 错误类型
  NetworkErrorType errorType;
  // 错误信息
  String errorMsg;

  NetworkError(this.errorType, this.errorMsg);
}

class NetworkManager {
  factory NetworkManager() => _sharedInstance();

  static Future start({@required String baseUrl}) async {
    NetworkManager()._lastStatus = await Connectivity().checkConnectivity();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none &&
          _instance._lastStatus == ConnectivityResult.none) {
        for (var delegate in _instance._delegates) {
          delegate.networkReconnect();
        }
      }
    });
    NetworkManager()._dio.options.baseUrl = baseUrl;
    return;
  }

  static addDelegate(NetworkManagerDelegate delegate) {
    if (!_instance._delegates.contains(delegate)) {
      _instance._delegates.add(delegate);
    }
  }

  static removeDelegate(NetworkManagerDelegate delegate) {
    if (_instance._delegates.contains(delegate)) {
      _instance._delegates.remove(delegate);
    }
  }

  static Future<dynamic> request({
    @required RequestMethod method,
    String url,
    Map<String, dynamic> queryParams,
    dynamic data,
    Map<String, dynamic> header,
  }) async {
    await _reconfigHeader(header);
    try {
      Response responses;
      switch (method) {
        case RequestMethod.get:
          responses =
              await _instance._dio.get(url, queryParameters: queryParams);
          break;
        case RequestMethod.post:
          responses = await _instance._dio
              .post(url, queryParameters: queryParams, data: data);
          break;
        case RequestMethod.put:
          responses = await _instance._dio
              .put(url, queryParameters: queryParams, data: data);
          break;
        case RequestMethod.delete:
          responses = await _instance._dio
              .delete(url, queryParameters: queryParams, data: data);
          break;
        case RequestMethod.head:
          responses = await _instance._dio
              .head(url, queryParameters: queryParams, data: data);
          break;
      }
      var resultData = responses.data;

      print('✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔');
      print('url: ${_instance._dio.options.baseUrl}${url}');
      print(resultData.toString());
      print('✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔✔');

      int code = resultData['statusCode'] ?? resultData['code'];

      if (code != null && code is int) {
        if (code >= 200 && code < 300) {
          return responses;
        } else if (code == 4000) {
          String msg = "检测到您的账号在别处登录,请重新登录";
          LoginManager.alertAndLogin(msg);
          var error = NetworkError(NetworkErrorType.server, msg);
          throw error;
        } else if (code == 401) {
          String msg = "登录过期,请重新登录";
          LoginManager.alertAndLogin(msg);
          var error = NetworkError(NetworkErrorType.server, msg);
          throw error;
        } else {
          var msg = resultData["errorInfo"] ?? resultData["msg"];
          var error = NetworkError(NetworkErrorType.server, msg.toString());
          throw error;
        }
      }
      var error = NetworkError(NetworkErrorType.custom, "网络错误, 请稍后重试!");
      throw error;
    } on DioError catch (e) {
      var error = NetworkError(NetworkErrorType.network, "网络错误, 请稍后重试!");
      print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      print('url: ${_instance._dio.options.baseUrl}${url}');
      print(e.message);
      print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      throw error;
    }
  }

  static _reconfigHeader(Map<String, dynamic> requestHeader) async {
    var headers = _instance._dio.options.headers;

    if (LoginManager()?.currentUser?.jrwyToken != null) {
      headers['JRWYTOKEN'] = LoginManager().currentUser.jrwyToken;
    }

    //TODO: 从Native中获取必要参数等
    if (requestHeader != null) {
      requestHeader.forEach((String key, dynamic value) {
        headers[key] = value;
      });
    }
    _instance._dio.options.headers = headers;
  }

  static NetworkManager _instance;
  ConnectivityResult _lastStatus;
  Set<NetworkManagerDelegate> _delegates = Set<NetworkManagerDelegate>();
  Dio _dio;
  NetworkManager._();

  static NetworkManager _sharedInstance() {
    if (_instance == null) {
      _instance = NetworkManager._();
      _instance._dio = Dio();
      _instance._dio.options.connectTimeout = 20000; //5s
      _instance._dio.options.receiveTimeout = 20000;
    }
    return _instance;
  }
}
