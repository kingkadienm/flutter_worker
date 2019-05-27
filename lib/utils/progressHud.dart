import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProgressHud extends StatelessWidget {

  const ProgressHud({
    Key key,
    this.loading = true,
    this.backColor = const Color(0x66000000),
  }): super(key: key);

  final bool loading;
  final Color backColor;

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      return Container(
        width: 0,
        height: 0,
      );
    }
    return Container(
      color: backColor,
      child: Center(
        child:  ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 80,
            height: 80,
            child: Container(
              color: Color(0x88000000),
              child: (Platform.isIOS) ?
              CupertinoActivityIndicator(radius: 20) :
              Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white))
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}