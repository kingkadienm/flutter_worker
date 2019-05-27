import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_worker/api/sso_api.dart';
import 'package:flutter_worker/base/views_factory.dart';
import 'package:flutter_worker/entity/account_model.dart';
import 'package:flutter_worker/login/manager/login_manager.dart';
import 'package:flutter_worker/network/network_manager.dart';
import 'package:flutter_worker/utils/validate_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginViewState();
  }
}

//手机号的控制器
TextEditingController phoneController;
//密码的控制器
TextEditingController passWordController;
//验证码控制器
//密码的控制器
TextEditingController autoCodeController;

class _LoginViewState extends State<LoginView> {
  //判断密码显示状态

  bool _selectView = true; //判断显示那个页面
  bool _autoCodeSelect = false;
  bool _passwordError = true; //判断错误信息是否显示
  FocusNode _focusNode;

  //账号登录和验证码登录选中未选中style
  TextStyle isSelectStyle() {
    return TextStyle(fontSize: ScreenUtil.getInstance().setSp(20));
  }

  TextStyle noSelectStyle() {
    return TextStyle(
        fontSize: ScreenUtil.getInstance().setSp(16), color: Color(0x80333333));
  }

  @override
  void initState() {
    // TODO: implement initState
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _autoCodeSelect = _focusNode.hasFocus;
      });
    });
    phoneController = TextEditingController();
    passWordController = TextEditingController();
    autoCodeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        resizeToAvoidBottomPadding: false, //输入框抵住键盘 内容不随键盘滚动
        body: ESWidgetFacotry.addWillPopScope(
            child: selectView(),
            context: context)
    );
  }

  //判断手机号
  void LoginReg() {
    if (!ValidateUtils.isChinaPhoneLegal(phoneController.text)) {
      //&&passWordController.text.length>0
      Fluttertoast.showToast(
          msg: "请输入正确手机号",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
    } else {
      _doLogin();
    }
  }

  //登录
  _LoginData() {
    _selectView
        ? LoginReg() //
        : print(
            {'phone': phoneController.text, 'code': autoCodeController.text});
  }
  static const jumpPlugin = const MethodChannel('com.wangzs.face/plugin');

  ///测试人脸识别
  Future<Null>  _testFace() async{
    await jumpPlugin.invokeMethod("face");
  }

  //https://uat-server.juranguanjia.com/api/web/user/message/sendcode?mobile&smsType&userType

  _doLogin() async {
    try {
      await SSOApi.login(mobile: phoneController.text, password: passWordController.text);
      LoginManager.loginComplete(context);
    } on NetworkError catch (e) {
      print(e.errorMsg);
      setState(() {
        _passwordError = false;
      });
    }
  }

  //初始化页面
  Widget selectView() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                top: ScreenUtil.getInstance().setHeight(102),
                left: ScreenUtil.getInstance().setWidth(20)),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    height: ScreenUtil.getInstance().setHeight(35),
                    child: Text(
                      "账号登录",
                      style: _selectView ? isSelectStyle() : noSelectStyle(),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectView = true;
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectView = false;
                      _passwordError = true;
                    });
                  },
                  child: Container(
                    height: ScreenUtil.getInstance().setHeight(35),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        left: ScreenUtil.getInstance().setWidth(30)),
                    child: Text(
                      "验证码登录",
                      style: _selectView ? noSelectStyle() : isSelectStyle(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          initView()
        ],
      ),
    );
  }

  //控制验证码下划线颜色
  Widget isSelectAutoCodeView() {
    return Container(
        height: ScreenUtil.getInstance().setHeight(2),
        color: Color(0xff2172f6));
  }

  Widget noSelectAutoCodeView() {
    return Container(
        height: ScreenUtil.getInstance().setHeight(1),
        color: Color(0xff666666));
  }
  bool _visibleIcon = true;
  //账号登录
  Widget passWordView() {
    return TextField(
      obscureText: _visibleIcon ? true : false,
      controller: passWordController,
      autofocus: false,
      decoration: InputDecoration(
          hintText: "请输入账号密码",
          suffixIcon: IconButton(
              icon: ImageIcon(
                  AssetImage(_visibleIcon
                      ? "images/sso/register_icon_close.png"
                      : "images/sso/register_icon_open.png"),
                  size: 18),
              onPressed: () {
                setState(() {
                  _visibleIcon = !_visibleIcon;
                });
                print(_visibleIcon);
              })),
    );
  }

  Timer _countdownTimer;

  String _codeCountdownStr = '获取验证码';
  int _countdownNum = 59;

  //验证码登录
  Widget autoCodeView() {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          Expanded(
            flex: 7,
            child: TextField(
              focusNode: _focusNode,
              controller: autoCodeController,
              autofocus: false, //自动获取焦点
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "请输入验证码",
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  child: Text(
                    _codeCountdownStr,
                    style: TextStyle(color: Color(0xff2172f6)),
                  ),
                  onTap: () {
                    if (_codeCountdownStr == "获取验证码") {
                      setState(() {
                        if (_countdownTimer != null) {
                          return;
                        }
                        // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
                        _codeCountdownStr = '${_countdownNum--}重新获取';
                        _countdownTimer = new Timer.periodic(
                            new Duration(seconds: 1), (timer) {
                          setState(() {
                            if (_countdownNum > 0) {
                              _codeCountdownStr = '${_countdownNum--}重新获取';
                            } else {
                              _codeCountdownStr = '获取验证码';
                              _countdownNum = 59;
                              _countdownTimer.cancel();
                              _countdownTimer = null;
                            }
                          });
                        });
                      });
                    }
                  },
                ),
              ))
        ]),
        _autoCodeSelect ? isSelectAutoCodeView() : noSelectAutoCodeView()
      ],
    );
  }

  // 不要忘记在这里释放掉Timer
  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    _focusNode.removeListener(() {});
    _focusNode = null;
    phoneController = null;
    passWordController = null;
    autoCodeController = null;
    super.dispose();
  }

  //手机号
  Widget TextFieldPhone() {
    return TextField(
      controller: phoneController,
      decoration: InputDecoration(hintText: "请输入手机号"),
      autofocus: false,
    );
  }

  //登录按钮
  Widget LoginButton() {
    return FlatButton(
        onPressed: () {
          _testFace();
//          _LoginData();
        },
        child: Text("登录"),
        color: Color(0xff2172f6),
        textColor: Colors.white);
  }

  Widget initView() {
    return Container(
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: ScreenUtil.getInstance().setWidth(20),
                top: ScreenUtil.getInstance().setWidth(50),
                right: ScreenUtil.getInstance().setWidth(20)),
            child: TextFieldPhone(),
          ),
          //判断是验证码还是密码
          Container(
              padding: EdgeInsets.only(
                  left: ScreenUtil.getInstance().setWidth(20),
                  top: ScreenUtil.getInstance().setWidth(47),
                  right: ScreenUtil.getInstance().setWidth(20)),
              child: _selectView ? passWordView() : autoCodeView()),
          Container(
              padding:
                  EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(9)),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(left: 20),
                          child: new Offstage(
                            offstage: _passwordError,
                            child: Text(
                              "密码错误，请重新输入",
                              style: TextStyle(
                                  color: Color(0xffee253e),
                                  fontSize: ScreenUtil.getInstance().setSp(12)),
                            ),
                          ))),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20),
                        alignment: Alignment.bottomRight,
                        child: _selectView
                            ? Text(
                                "忘记密码",
                                style: TextStyle(
                                    color: Color(0xff2172f6),
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(12)),
                              )
                            : Text("")),
                  ),
                ],
              )),
          Container(
              margin:
                  EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(20)),
              padding: EdgeInsets.only(
                  left: ScreenUtil.getInstance().setWidth(20),
                  right: ScreenUtil.getInstance().setWidth(20)),
              width: MediaQuery.of(context).size.width,
              height: ScreenUtil.getInstance().setHeight(47),
              child: LoginButton()),
          Container(
              margin:
                  EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(18)),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "登录即表示您同意",
                    style: TextStyle(
                        color: Color(0xff4b5461),
                        fontSize: ScreenUtil.getInstance().setSp(12)),
                  ),
                  GestureDetector(
                    child: Text("《技师用户服务协议》",
                        style: TextStyle(
                            color: Color(0xff2172f6),
                            fontSize: ScreenUtil.getInstance().setSp(12))),
                    onTap: () {
                      print("技师用户协议");
                    },
                  )
                ],
              ))
        ],
      ),
    );
  }

  //清空控制器
  void onTextClear() {
    setState(() {
      phoneController.clear();
      passWordController.clear();
    });
  }
}
