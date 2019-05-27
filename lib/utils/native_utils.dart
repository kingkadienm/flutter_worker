import 'package:flutter/services.dart';
import 'dart:async';      // 异步
class NativeUtils{

  static const platform = const MethodChannel("samples.flutter.io/macAddress");
  String _macAddress = "Unknown Mac Address";

  static Future<String> getMacAddress() async {
    String macAddress;
    try{
      print('1111111111111111');
      // 在通道上调用此方法
      String  result = await platform.invokeMethod('getMacAddress');
      macAddress = '$result';
      return result;
    } on PlatformException catch (e){
      macAddress = "test=='${e.message}'.";
    }
  }


}