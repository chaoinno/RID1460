import 'package:RID1460/Pages/forgot_password.dart';
import 'package:RID1460/Pages/registration.dart';
import 'package:RID1460/Utilities/nomal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_nav_parent.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String email, password, confirmPassword;
  final fromkey = GlobalKey<FormState>();

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
        style: TextStyle(
            fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
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
            style: TextStyle(color: Colors.grey),
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
            style: TextStyle(color: Colors.orange),
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
        saveSharePerence();
        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext context) => BottomNavBarParent());
        Navigator.of(context).pushReplacement(materialPageRoute);
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
            style: TextStyle(color: Colors.white),
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
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future<void> loginApi() async {
    String url = '';
    Dio dio = new Dio();
    Response response = await dio.post(url,
        data: {
          "email": email,
          "password": password,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));

    var result = response.data;
    //ถ้าข้อมูลList
  }

  Future<void> saveSharePerence() async {
    List<String> list = List();
    list.add(email);
    list.add(password);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('User', list);
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
