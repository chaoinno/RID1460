import 'package:RID1460/Pages/newcase.dart';
import 'package:RID1460/Utilities/nomal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String email, password, confirmPassword, prefixName, firstName, lastName;
  final fromkey = GlobalKey<FormState>();

  Widget logo() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/RID-logo-cmyk-TH.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget titleform(String title) {
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
        title,
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
          SizedBox(width: 15.0),
          Flexible(
            flex: 3,
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              onSaved: (String string) {
                email = string.trim();
              },
              validator: (value) => value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
              decoration: InputDecoration(
                labelText: 'อีเมล (ID) *',
                hintText: 'user@mail.com',
              ),
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
          SizedBox(width: 15.0),
          Flexible(
            flex: 3,
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              onSaved: (String string) {
                password = string.trim();
              },
              validator: (value) => value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
              decoration: InputDecoration(
                labelText: 'รหัสผ่าน *',
                hintText: 'รหัสผ่าน',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget confirmPasswordForm() {
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
          SizedBox(width: 15.0),
          Flexible(
            flex: 3,
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              onSaved: (String string) {
                confirmPassword = string.trim();
              },
              validator: (value) => value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
              decoration: InputDecoration(
                labelText: 'ยืนยันรหัสผ่าน *',
                hintText: 'รหัสผ่าน',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget prefixNameForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 3,
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              onSaved: (String string) {
                prefixName = string.trim();
              },
              validator: (value) => value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
              decoration: InputDecoration(
                labelText: 'คำนำหน้าชื่อ *',
                hintText: 'นาย / นางสาว / นาง / ฯลฯ',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget firstNameForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.38,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 3,
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              onSaved: (String string) {
                prefixName = string.trim();
              },
              validator: (value) => value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
              decoration: InputDecoration(
                labelText: 'ชื่อ *',
                hintText: 'ชื่อ',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget lastNameForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.39,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 3,
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              onSaved: (String string) {
                lastName = string.trim();
              },
              validator: (value) => value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
              decoration: InputDecoration(
                labelText: 'นามสกุล *',
                hintText: 'นามสกุล',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget forgotButton() {
    return InkWell(
      onTap: () {},
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
      onTap: () {},
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
            builder: (BuildContext context) => Newcase(
                  title: email,
                ));
        Navigator.of(context).pop();
        Navigator.of(context).push(materialPageRoute);
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
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        height: 40,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.orange,
        ),
        child: Center(
          child: Text(
            'ลงทะเบียนด้วย FACEBOOK',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future<void> loginApi() async {
    String url = '';
    Dio dio = new Dio();
    Response response = await dio.post(
      url,
      data: {
        "email": email,
        "password": password,
      },
      //options:  Options(contentType: Headers.formUrlEncodedContentType)
    );

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
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("ลงทะเบียนสมาชิก")),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
          Center(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: facebookButton(),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  width: MediaQuery.of(context).size.width * 0.9,
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
                        titleform("ข้อมูลเข้าใช้ระบบ"),
                        emailForm(),
                        passwordForm(),
                        confirmPasswordForm(),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.only(bottom: 20.0),
                  width: MediaQuery.of(context).size.width * 0.9,
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
                      ]),
                  child: Form(
                    child: Column(
                      children: [
                        titleform("ข้อมูลสมาชิก"),
                        prefixNameForm(),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            children: [
                              firstNameForm(),
                              SizedBox(width: 10.0),
                              lastNameForm()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
