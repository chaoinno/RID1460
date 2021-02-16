import 'dart:convert';

import 'package:RID1460/Utilities/nomal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Newcase extends StatefulWidget {
  final String title;

  const Newcase({Key key, this.title}) : super(key: key);
  @override
  _NewcaseState createState() => _NewcaseState();
}

class _NewcaseState extends State<Newcase> {
  //fields
  final fromkey = GlobalKey<FormState>();
  String email, sessionId;
  static List serviceTypes;
  @override
  void initState() {
    super.initState();
  }

  //methods
  Future<void> readSharedPreferance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List userInfo = sharedPreferences.getStringList('UserInfo');
    print(userInfo);
    setState(() {
      email = userInfo[0];
      sessionId = userInfo[6];
    });
  }

  static Future<void> parseServiceTypes(String url) async {
    Response response = await Dio().get(url);

    var result = response.data;
    //print(result);
    // Province collection = Province.fromJson(result);
    // Map<dynamic, dynamic> map = jsonDecode(collection.getProvinceResult);

    // GetProvinceResult provinceResults = GetProvinceResult.fromJson(map);
    // serviceTypes = [];
    // for (var item in provinceResults.value) {
    //   serviceTypes.add({
    //     "label": ProvinceValue.fromJson(item).label,
    //     "value": ProvinceValue.fromJson(item).value
    //   });
    // }
  }

  //widgets

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

  Widget titleform(String title) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
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
        style: GoogleFonts.kanit(
            textStyle: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        )),
      )),
    );
  }

  Widget saveButton() {
    return InkWell(
      onTap: () {
        fromkey.currentState.save();
        // updateProfiileProcess();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
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
            'บันทึกข้อมูล',
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
        //appBar: AppBar(centerTitle: true, title: Text("$title")),
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              "แจ้งเรื่องร้องเรียนใหม่",
              style: GoogleFonts.kanit(),
            )),
        body: Center(
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("images/bg1.png"),
              fit: BoxFit.cover,
            )),
            child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
            Form(
              key: fromkey,
              child: Center(
                child: Column(
                  children: [
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            )
                          ]),
                      child: Center(
                        child: Column(
                          children: [
                            titleform("ข้อมูลสมาชิก"),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Row(
                                children: [
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10.0),
                              width: MediaQuery.of(context).size.width * 0.8,
                            ),
                            Container(
                              child: Row(
                                children: [
                                ],
                              ),
                            ),
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            )
                          ]),
                      child: Center(
                        child: Column(
                          children: [
                            titleform("ข้อมูลสมาชิก"),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Row(
                                children: [
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10.0),
                              width: MediaQuery.of(context).size.width * 0.8,
                            ),
                            Container(
                              child: Row(
                                children: [
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: saveButton(),
                    ),
                  ],
                ),
              ),
            ),
          ]),
          ),
        ),
      ),
    );
  }
}
