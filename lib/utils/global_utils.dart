import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalUtils {
  factory GlobalUtils() => _sharedInstance();

  BuildContext rootContext;

  GlobalUtils._();
  static GlobalUtils _instance;

  static GlobalUtils _sharedInstance() {
    if (_instance == null) {
      _instance = GlobalUtils._();
    }
    return _instance;
  }


}
