import 'dart:convert';

import 'package:RID1460/Utilities/global_resources.dart';
import 'package:RID1460/Utilities/nomal_dialog.dart';
import 'package:RID1460/models/account_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String fullName, email, sessionId, idCardNo, province, district, subdistrict, postalCode, phoneNumber;
  final fromkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    readSharedPreferance();
  }

  Future<void> getAccountDetails() async {
    String url = GlobalResources().apiHost + 'wcfrest.svc/getAccountDetail?sessionid=$sessionId';
    print(url);
    Dio dio = new Dio();
    try {
      Response response = await dio.get(url);
      // print(response);
      var result = response.data;
      AccountDetail autogenerated = AccountDetail.fromJson(result);
      // print(autogenerated.getAccountDetailResult);
      Map<dynamic, dynamic> map = jsonDecode(autogenerated.getAccountDetailResult);
      // print(map);
      GetAccountDetailResult getAccountDetatilResult = GetAccountDetailResult.fromJson(map);
      print(getAccountDetatilResult.account);
      if (getAccountDetatilResult.result == 'error') {
        normalDialog(context, 'ผิดพลาด', getAccountDetatilResult.msg);
      } else {
        print(getAccountDetatilResult.account);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> readSharedPreferance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List userInfo = sharedPreferences.getStringList('UserInfo');
    print(userInfo);
    setState(() {
      fullName = userInfo[1] + ' ' + userInfo[2];
      email = userInfo[0];
      sessionId = userInfo[6];
    });
    print(fullName);
    print(email);

    getAccountDetails();
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
          "ข้อมูลสมาชิก",
          style: GoogleFonts.kanit(
            textStyle: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
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
        appBar: AppBar(
          title: Text(
            'ข้อมูลสมาชิก',
            style: GoogleFonts.kanit(),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.edit),
                )),
          ],
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
                      margin: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              fullName ?? '',
                              style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              email ?? '',
                              style: GoogleFonts.kanit(),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'รหัสประจำตัวประชาชน',
                                    style: GoogleFonts.kanit(),
                                  ),
                                  Text(
                                    'data',
                                    style: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'ที่อยู่',
                                    style: GoogleFonts.kanit(),
                                  ),
                                  Text(
                                    'data',
                                    style: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'จังหวัด',
                                              style: GoogleFonts.kanit(),
                                            ),
                                            Text(
                                              'data',
                                              style: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'อำเภอ',
                                              style: GoogleFonts.kanit(),
                                            ),
                                            Text(
                                              'data',
                                              style: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'ตำบล',
                                              style: GoogleFonts.kanit(),
                                            ),
                                            Text(
                                              'data',
                                              style: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'รหัสไปรษณีย์',
                                              style: GoogleFonts.kanit(),
                                            ),
                                            Text(
                                              'data',
                                              style: GoogleFonts.kanit(
                                                textStyle: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'หมายเลขโทรศัพท์',
                                    style: GoogleFonts.kanit(),
                                  ),
                                  Text(
                                    'data',
                                    style: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.orange,
                                      ),
                                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}