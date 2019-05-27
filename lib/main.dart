import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter_worker/utils/appStart_utils.dart';

import 'base/init_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  bool isComplete = false;

  @override
  void initState() {

    super.initState();
    AppStartUtils.start(() {
      setState(() {
        isComplete = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    if (Platform.isIOS) {
      return CupertinoApp(

        theme: CupertinoThemeData(
          primaryColor: Color(0xFFFFFFFF),
          barBackgroundColor: Color(0xFF2172F6),
        ),
        home: isComplete ? InitView() : _AppStartEmpty(),
      );
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFF2172F6,
          <int, Color>{
            50: Color(0xFF2172F6),
            100: Color(0xFF2172F6),
            200: Color(0xFF2172F6),
            300: Color(0xFF2172F6),
            400: Color(0xFF2172F6),
            500: Color(0xFF2172F6),
            600: Color(0xFF2172F6),
            700: Color(0xFF2172F6),
            800: Color(0xFF2172F6),
            900: Color(0xFF2172F6),
          },
        ),
      ),
      home: isComplete ? InitView() : _AppStartEmpty(),
    );
  }
}

class _AppStartEmpty extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
    );
  }
}
