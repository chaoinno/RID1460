import 'dart:convert';

import 'package:RID1460/Utilities/global_resources.dart';
import 'package:RID1460/Utilities/nomal_dialog.dart';
import 'package:RID1460/models/web_api_result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  ProgressDialog progressDialog;
  String email;
  final fromkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> normalDialog(
      BuildContext context, String title, String massage) async {
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: showTitile(title, massage),
            actions: [
              okButton(context),
            ],
          );
        });
  }

  Future<void> forgotPasswordProcess() async {
    String url =
        GlobalResources().apiHost + 'wcfrest.svc/resetpassword?username=$email';
    print(url);
    Dio dio = new Dio();
    try {
      Response response = await dio.get(url);
      print(response);
      var result = response.data;
      WebApiResult collection =
          WebApiResult.fromJson(result, 'resetpasswordResult');
      Map<dynamic, dynamic> map = jsonDecode(collection.collectionResult);
      CollectionResult collectionResult = CollectionResult.fromJson(map);
      if (collectionResult.result == 'error') {
        progressDialog.hide();
        normalDialog(context, 'ผิดพลาด', collectionResult.msg);
      } else {
        progressDialog.hide();
        showDialog(
            context: context,
            builder: (BuildContext buildContext) {
              return AlertDialog(
                title: ListTile(
                  leading: Icon((Icons.add_alert)),
                  title: Text('ดำเนินการสำเร็จ'),
                  subtitle: Text(collectionResult.msg),
                ),
                actions: [
                  FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                        Navigator.pop(context);
                      }),
                ],
              );
            });
      }
    } catch (e) {
      print(e);
    }
  }

  Widget submitButton() {
    return InkWell(
      onTap: () {
        progressDialog.show();
        fromkey.currentState.save();
        if (email.isEmpty) {
          print("email isEmpty");
          normalDialog(context, 'Email', 'กรุณากรอก email');
          return;
        }
        progressDialog.hide().whenComplete(() {
          forgotPasswordProcess();
        });
      },
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.orange,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )
          ],
        ),
        child: Center(
          child: Text(
            'ตั้งรหัสผ่านใหม่',
            style: GoogleFonts.kanit(
              textStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
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
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
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
        "ระบุอีเมลเพื่อตั้งรหัสผ่านใหม่",
        style: GoogleFonts.kanit(
          textStyle: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      )),
    );
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
        appBar: AppBar(
          title: Text(
            'ลืมรหัสผ่าน',
            style: GoogleFonts.kanit(),
          ),
        ),
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
              Form(
                key: fromkey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 15),
                      margin: const EdgeInsets.all(20),
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
                      child: Column(
                        children: [
                          titleform(),
                          emailForm(),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          submitButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
