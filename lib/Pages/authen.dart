import 'dart:convert';
import 'dart:io';

import 'package:RID1460/Pages/forgot_password.dart';
import 'package:RID1460/Pages/registration.dart';
import 'package:RID1460/Utilities/global_resources.dart';
import 'package:RID1460/Utilities/nomal_dialog.dart';
import 'package:RID1460/models/login.dart';
import 'package:RID1460/models/login_social.dart';
import 'package:client_information/client_information.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_nav_parent.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

String prettyPrint(Map json) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

class _AuthenState extends State<Authen> {
//Fields
  ProgressDialog progressDialog;

  String email, password, confirmPassword;
  final fromkey = GlobalKey<FormState>();

  String imeiString;

  Map<String, dynamic> _userData;
  AccessToken _accessToken;
  bool _checking = true;

  @override
  void initState() {
    super.initState();
    getImei();

    _checkIfIsLogged();
  }

// Widgets

  Widget logo() {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/RID-logo-cmyk-TH.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget titleform() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width * 0.9,
      // color: Colors.white,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.blue,
        //border: Border.all(color:Colors.red),
      ),
      child: Center(
          child: Text(
        "เข้าสู่ระบบ",
        style: GoogleFonts.kanit(
          textStyle: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      )),
    );
  }

  Widget emailForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            // margin: EdgeInsets.all(10),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/social-media (1).png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: TextFormField(
              onSaved: (String string) {
                email = string.trim();
              },
              decoration: InputDecoration(hintText: 'อีเมล'),
            ),
          ),
        ],
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            // margin: EdgeInsets.all(10),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/key.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: TextFormField(
              onSaved: (String string) {
                password = string.trim();
              },
              decoration: InputDecoration(hintText: 'รหัสผ่าน'),
              obscureText: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget forgotButton() {
    return InkWell(
      onTap: () {
        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext context) => ForgotPassword());
        Navigator.of(context).push(materialPageRoute);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        decoration: BoxDecoration(),
        child: Center(
          child: Text(
            'ลืมรหัสผ่าน',
            style: GoogleFonts.kanit(
              textStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  Widget registerButton() {
    return InkWell(
      onTap: () {
        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext context) => Registration());
        Navigator.of(context).push(materialPageRoute);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        decoration: BoxDecoration(),
        child: Center(
          child: Text(
            'ลงทะเบียนสมาชิกใหม่',
            style: GoogleFonts.kanit(
              textStyle: TextStyle(color: Colors.orange),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return InkWell(
      onTap: () {
        progressDialog.show();
        fromkey.currentState.save();
        if (email.isEmpty) {
          print("email isEmpty");
          normalDialog(context, 'Email', 'กรุณากรอก email');
          return;
        }
        if (password.isEmpty) {
          print("password isEmpty");
          normalDialog(context, 'password', 'กรุณากรอก password');
          return;
        }
        // loginApi();
        // print("object");
        progressDialog.hide().whenComplete(() {
          loginApi();
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        height: 40,
        width: MediaQuery.of(context).size.width * 0.7,
        // color: Colors.white,ß
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),

          color: Colors.blue,

          //border: Border.all(color:Colors.red),
        ),

        child: Center(
          child: Text(
            'เข้าสู่ระบบ',
            style: GoogleFonts.kanit(
              textStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget facebookButton() {
    return InkWell(
      onTap: () {
        print('Facebook Auth Precessing....');
        _login();
        if (_userData != null) {
          socialLoginApi();
        }
        // MaterialPageRoute materialPageRoute = MaterialPageRoute(
        //     builder: (BuildContext context) => BottomNavBarParent());
        // Navigator.of(context).push(materialPageRoute);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        height: 40,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.orange,
        ),
        child: Center(
          child: Text(
            'เข้าสู่ระบบด้วย FACEBOOK',
            style: GoogleFonts.kanit(
              textStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

// Methods
  /// Support on iOS, Android and web project
  Future<String> getDeviceId() async {
    return (await ClientInformation.fetch()).deviceId;
  }

  // start facebook log in

  Future<void> _checkIfIsLogged() async {
    final AccessToken accessToken = await FacebookAuth.instance.isLogged;
    setState(() {
      _checking = false;
    });
    if (accessToken != null) {
      print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      // now you can call to  FacebookAuth.instance.getUserData();
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    }
  }

  void _printCredentials() {
    print(
      prettyPrint(_accessToken.toJson()),
    );
  }

  Future<void> _login() async {
    try {
      // show a circular progress indicator
      setState(() {
        _checking = true;
      });
      _accessToken = await FacebookAuth.instance
          .login(); // by the fault we request the email and the public profile
      // loginBehavior is only supported for Android devices, for ios it will be ignored
      // _accessToken = await FacebookAuth.instance.login(
      //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
      //   loginBehavior:
      //       LoginBehavior.DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
      // );
      _printCredentials();
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _userData = userData;
      print(_userData['name']);
    } on FacebookAuthException catch (e) {
      // if the facebook login fails
      print(e.message); // print the error message in console
      // check the error type
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          print("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          print("login failed");
          break;
      }
    } catch (e, s) {
      // print in the logs the unknown errors
      print(e);
      print(s);
    } finally {
      // update the view
      setState(() {
        _checking = false;
      });
    }
  }


  // end facebook log in

  Future<void> socialLoginApi() async {
    String url = GlobalResources().apiHost + 'wcfrest.svc/login_social';
    Dio dio = new Dio();

    var o = _accessToken.toJson();

    var param = {
      "username": o['userId'],
      "DeviceName": password,
      "Searial": imeiString,
      "SocialName": _userData['name'],
      "TokenID": o['token'],
      "OS_Type": Platform.isAndroid
          ? "android"
          : Platform.isIOS
              ? "iOS"
              : "Unknown"
    };

    String paramJson = jsonEncode(param);
    print(paramJson);
    try {
      Response response = await dio.post(url,
          data: paramJson,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));
      var result = response.data;
      LogInSocialResult collection = LogInSocialResult.fromJson(result);
      print(collection.loginSocialResult);
      Map<dynamic, dynamic> map = jsonDecode(collection.loginSocialResult);
      LoginResult collectionResult = LoginResult.fromJson(map);
      if (collectionResult.result == 'success') {
        List<String> list = List();
        list.add(collectionResult.email);
        list.add(collectionResult.firstname);
        list.add(collectionResult.lastname);
        list.add(collectionResult.msg);
        list.add(collectionResult.result);
        list.add(collectionResult.role);
        list.add(collectionResult.sessionID);
        list.add(collectionResult.telephone);
        list.add(collectionResult.tokenID);
        list.add(collectionResult.userID);

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setStringList('UserInfo', list);

        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext context) => BottomNavBarParent());
        Navigator.of(context).pushReplacement(materialPageRoute);
      } else {
        normalDialog(context, 'ผิดพลาด', collectionResult.msg);
      }
    } catch (e) {
      print(e);
    }
  }

  getImei() async {
    // var imei = await ImeiPlugin.getImei();
    var imei = await getDeviceId();

    setState(() {
      imeiString = imei.toString();
    });
    print('Running on $imei');
  }

  Future<void> loginApi() async {
    String url = GlobalResources().apiHost + 'wcfrest.svc/login';
    Dio dio = new Dio();

    var param = {
      "username": email,
      "password": password,
      "Searial": imeiString,
      "TokenID": "",
      "OS_Type": Platform.isAndroid
          ? "android"
          : Platform.isIOS
              ? "iOS"
              : "Unknown"
    };

    String paramJson = jsonEncode(param);
    print(paramJson);
    try {
      Response response = await dio.post(url,
          data: paramJson,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));
      var result = response.data;
      Login collection = Login.fromJson(result);
      print(collection.loginResult);
      Map<dynamic, dynamic> map = jsonDecode(collection.loginResult);
      LoginResult collectionResult = LoginResult.fromJson(map);
      if (collectionResult.result == 'success') {
        List<String> list = List();
        list.add(collectionResult.email);
        list.add(collectionResult.firstname);
        list.add(collectionResult.lastname);
        list.add(collectionResult.msg);
        list.add(collectionResult.result);
        list.add(collectionResult.role);
        list.add(collectionResult.sessionID);
        list.add(collectionResult.telephone);
        list.add(collectionResult.tokenID);
        list.add(collectionResult.userID);

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setStringList('UserInfo', list);

        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext context) => BottomNavBarParent());
        Navigator.of(context).pushReplacement(materialPageRoute);
      } else {
        normalDialog(context, 'ผิดพลาด', collectionResult.msg);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("ลงชื่อเข้าใช้"),
        // ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.5,
                      child: logo(),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          )
                        ],
                      ),
                      child: Form(
                        key: fromkey,
                        child: Column(
                          children: [
                            titleform(),
                            emailForm(),
                            passwordForm(),
                            loginButton(),
                            facebookButton(),
                            Row(
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: forgotButton()),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: registerButton()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
