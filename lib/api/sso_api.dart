import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_worker/entity/account_model.dart';
import 'package:flutter_worker/login/manager/login_manager.dart';
import 'package:flutter_worker/network/network_manager.dart';

class SSOApi {


  static Future login({String mobile, String password}) async {
    var url = '/auth/accredit';

      Response response = await NetworkManager.request(
        method: RequestMethod.post,
        url: url,
        data: {'mobile': mobile, 'password': password, 'userType': 2},
      );

      var result = response.data['data'] as Map<String, dynamic>;

      if (result != null) {
        LoginManager().currentUser = AccountModel.fromJson(result);

        var technicianId = await _getTechnicianId(userId: LoginManager().currentUser.userid);
        LoginManager().currentUser.technicianId = technicianId;

        return;
      }
      throw NetworkError(NetworkErrorType.custom, '格式错误');

  }

  static _getTechnicianId({@required int userId}) async {
    var url = '/user/user/info/technicianid';

    Response response = await NetworkManager.request(
      method: RequestMethod.get,
      url: url,
      queryParams: {'userId' : userId},
    );

    var technicianId = response.data['data'] as int;

    if (technicianId != null) {
      return technicianId;
    }
    throw NetworkError(NetworkErrorType.custom, '格式错误');
  }
}