import 'package:shared_preferences/shared_preferences.dart';

//sp 保存工具类
class SharePreferenceUtils {
  factory SharePreferenceUtils() => _getInstance();

  static SharePreferenceUtils get instance => _getInstance();
  static SharePreferenceUtils _instance;

  SharePreferenceUtils._internal() {
    // 初始化
  }

  static SharePreferenceUtils _getInstance() {
    if (_instance == null) {
      _instance = new SharePreferenceUtils._internal();
    }
    return _instance;
  }

  //添加
  Future<bool> sharedAddAndUpdate(String key, Object dataType, Object data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch (dataType) {
      case bool:
        return sharedPreferences.setBool(key, data);
      case double:
        return sharedPreferences.setDouble(key, data);
      case int:
        return sharedPreferences.setInt(key, data);
      case String:
        return sharedPreferences.setString(key, data);
      case List:
        return sharedPreferences.setStringList(key, data);
      default:
        return sharedPreferences.setString(key, data.toString());
    }
  }


  Future<Object> sharedGetData(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences != null) {
      return sharedPreferences.get(key);
    }
    return null;
  }

  //删除
  Future<bool> sharedDeleteData(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences != null) {
      return sharedPreferences.remove(key);
    }
    return false;
  }
}
