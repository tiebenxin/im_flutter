import 'package:cxdemo/dio/address.dart';
import 'package:cxdemo/dio/data_helper.dart';
import 'package:cxdemo/dio/http_manager.dart';
import 'package:cxdemo/dio/result_data.dart';
import 'package:cxdemo/model/token_bean.dart';
import 'package:cxdemo/utils/device_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //焦点
  FocusNode _focusNodeUserName = new FocusNode();
  FocusNode _focusNodePassWord = new FocusNode();

  //用户名输入框控制器，此控制器可以监听用户名输入框操作
  TextEditingController _userNameController = new TextEditingController();

  //表单状态
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _password = ''; //用户名
  var _username = ''; //密码
  var _isShowPwd = false; //是否显示密码
  var _isShowClear = false; //是否显示输入框尾部的清除按钮
  var deviceId = ''; //设备Id;
  var phoneModel = ''; //手机品牌
  var deviceName = ''; //手机名字

  @override
  void initState() {
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);
    //监听用户名框的输入改变
    _userNameController.addListener(() {
      print(_userNameController.text);

      // 监听文本框输入变化，当有内容的时候，显示尾部清除按钮，否则不显示
      if (_userNameController.text.length > 0) {
        _isShowClear = true;
      } else {
        _isShowClear = false;
      }
      setState(() {});
    });
    initDeviceInfo();
    super.initState();
  }

  @override
  void dispose() {
    // 移除焦点监听
    _focusNodeUserName.removeListener(_focusNodeListener);
    _focusNodePassWord.removeListener(_focusNodeListener);
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    //logo图片区域
    Widget logoImageArea = new Container(
      alignment: Alignment.topCenter,
      child: ClipOval(
        child: Image.asset("assets/images/default_image.webp",
            height: 100, width: 100, fit: BoxFit.cover),
      ),
    );

    Widget inputTextArea = new Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      child: new Form(
          key: _formKey,
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new TextFormField(
                controller: _userNameController,
                focusNode: _focusNodeUserName,
                //设置键盘类型，文本，数字，密码等等
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "手机号/账号",
                  hintText: "请输入手机号或者常信号",
                  prefixIcon: Icon(Icons.person),
                  //尾部添加清除按键
                  suffixIcon: (_isShowClear)
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            //清除输入内容
                            _userNameController.clear();
                          },
                        )
                      : null,
                ),
                //验证用户名（手机号） //暂不验证
//                validator: validateUserName,
                //保存数据
                onSaved: (String value) {
//                  _username = value;
                  _username = "15377311916";
                },
              ),
              new TextFormField(
                focusNode: _focusNodePassWord,
                decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "请输入密码",
                    prefixIcon: Icon(Icons.lock),
                    //是否显示密码
                    suffixIcon: IconButton(
                        icon: Icon((_isShowPwd)
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isShowPwd = !_isShowPwd;
                          });
                        })),
                obscureText: !_isShowPwd,
//                validator: validatePassWord,//暂不检测空指针
                onSaved: (String value) {
//                  _password = value;
                  _password = "123456";
                },
              )
            ],
          )),
    );

    //登录按钮区域
    Widget loginButtonArea = new Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 45,
      child: new RaisedButton(
          color: Colors.blue[300],
          child: Text(
            "登录",
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
            //点击登录按钮，解除焦点，回收键盘
            _focusNodePassWord.unfocus();
            _focusNodeUserName.unfocus();
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              //todo 登录操作
              print("$_username + $_password");
//              Api.apiLogin();
              login(_username, _password);
            }
          }),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      //外层添加一个手势，用于点击空白部分，回收键盘
      body: new GestureDetector(
        onTap: () {
          //点击空白区域，回收键盘
          print("点击了空白区域");
          _focusNodeUserName.unfocus();
          _focusNodePassWord.unfocus();
        },
        child: new ListView(
          children: <Widget>[
            new SizedBox(
              height: ScreenUtil.getInstance().setHeight(80),
            ),
            logoImageArea,
            new SizedBox(
              height: ScreenUtil.getInstance().setHeight(70),
            ),
            inputTextArea,
            new SizedBox(
              height: ScreenUtil.getInstance().setHeight(80),
            ),
            loginButtonArea,
          ],
        ),
      ),
    );
  }

  // 监听焦点
  Future<Null> _focusNodeListener() async {
    if (_focusNodeUserName.hasFocus) {
      print("用户名框获取焦点");
      // 取消密码框的焦点状态
      _focusNodePassWord.unfocus();
    }
    if (_focusNodePassWord.hasFocus) {
      print("密码框获取焦点");
      // 取消用户名框焦点状态
      _focusNodeUserName.unfocus();
    }
  }

  void initDeviceInfo() {
    Future<String> future1 = DeviceUtil.getDeviceId();
    future1.then((value) => deviceId = value);
    Future<String> future2 = DeviceUtil.getPhoneModel();
    future2.then((value) => phoneModel = value);
    Future<String> future3 = DeviceUtil.getDeviceName();
    future3.then((value) => deviceName = value);
  }

  /**
   * 验证用户名
   */
  String validateUserName(value) {
    // 正则匹配手机号
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    if (value.isEmpty) {
      return '用户名不能为空!';
    } else if (!exp.hasMatch(value)) {
      return '请输入正确手机号';
    }
    return null;
  }

  /**
   * 验证密码
   * */
  String validatePassWord(value) {
    if (value.isEmpty) {
      return '密码不能为空';
    } else if (value.trim().length < 6 || value.trim().length > 18) {
      return '密码长度不正确';
    }
    return null;
  }

  void login(phone, password) async {
    var params = DataHelper.getBaseMap();
    params.clear();
    params["phone"] = phone;
    params["password"] = DataHelper.string2MD5(password);
    params["devid"] = deviceId; //极光推送设备id
    params["platform"] = "Android";
    params["phoneModel"] = phoneModel;
    params["installChannel"] = "default_android";
    params["deviceDetail"] = deviceId; //本机设备id或imei
    params["deviceName"] = deviceName; //本机设备id或imei

    ResultData resultData = await HttpManager.getInstance()
        .post(Address.LOGIN_BY_PHOME, params: params);
    setState(() {
      if (resultData.isSuccess) {
        TokenBean tokenBean = TokenBean.fromJson(resultData.data);
        if(tokenBean != null){

        }
      } else {}
    });
  }
}
