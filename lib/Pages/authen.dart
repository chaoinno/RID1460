import 'dart:convert';
import 'dart:io';

import 'package:RID1460/Pages/forgot_password.dart';
import 'package:RID1460/Pages/registration.dart';
import 'package:RID1460/Utilities/global_resources.dart';
import 'package:RID1460/Utilities/nomal_dialog.dart';
import 'package:RID1460/models/login.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_nav_parent.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

//Fields

  String email, password, confirmPassword;
  final fromkey = GlobalKey<FormState>();

  String imeiString;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getImei();
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
        loginApi();
        // print("object");
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
  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceData;

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  getImei() async {
    var imei = await ImeiPlugin.getImei();

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
