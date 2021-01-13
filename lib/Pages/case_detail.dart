import 'dart:convert';

import 'package:RID1460/Utilities/global_resources.dart';
import 'package:RID1460/Utilities/nomal_dialog.dart';
import 'package:RID1460/models/service_case.dart';
import 'package:RID1460/models/service_case_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CaseDetail extends StatefulWidget {
  final String srId;
  CaseDetail({Key key, this.srId}) : super(key: key);
  @override
  _CaseDetailState createState() => _CaseDetailState();
}

class _CaseDetailState extends State<CaseDetail> {
// Fields
  String email, sessionId;
  ServiceCaseList service = ServiceCaseList();
  List<LsAttach> lsAttach = List<LsAttach>();

  final fromkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    readSharedPreferance();
  }

// Methods
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> getServiceCaseDetails() async {
    String url = GlobalResources().apiHost +
        'wcfrest.svc/getServiceDetail?sessionid=${sessionId}&SRID=${widget.srId}';
    print(url);
    Dio dio = new Dio();
    try {
      Response response = await dio.get(url);
      var result = response.data;
      // print(result);
      ServiceCaseDetail autogenerated = ServiceCaseDetail.fromJson(result);
      // print(autogenerated.getServiceDetailResult);
      Map<dynamic, dynamic> map =
          jsonDecode(autogenerated.getServiceDetailResult);
      // print(map);
      GetServiceDetailResult getServiceDetailResult =
          GetServiceDetailResult.fromJson(map);
      // print(getServiceDetailResult.service);
      // LsAttach lsAttach = LsAttach.fromJson(getServiceDetailResult.lsAttach);
      // print(lsAttach);

      if (getServiceDetailResult.result == 'error') {
        normalDialog(context, 'ผิดพลาด', getServiceDetailResult.msg);
      } else {
        setState(() {
          service = ServiceCaseList.fromJson(getServiceDetailResult.service);
          for (var item in getServiceDetailResult.lsAttach) {
            lsAttach.add(LsAttach.fromJson(item));
          }
        });
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
      email = userInfo[0];
      sessionId = userInfo[6];
    });
    getServiceCaseDetails();
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

// Widgets
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

  Widget caseStatusView() {
    return Container(
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
          titleform('สถานะเรื่อง'),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        'รหัสเรื่อง',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: Text(
                        service.code ?? '-',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        'วันที่แจ้ง',
                        style: GoogleFonts.kanit(),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: Text(
                        service.openDate ?? '-',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        'วันที่ยุติ',
                        style: GoogleFonts.kanit(),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: Text(
                        service.closeDate ?? '-',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        'สถานะ',
                        style: GoogleFonts.kanit(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Text(
                        service.statusName ?? '-',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget caseDetailView() {
    return Container(
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
          titleform('รายละเอียด'),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Text(
                        'ประเภทเรื่อง',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: Text(
                        service.catagoryName ?? '-',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Text(
                        'รายละเอียด',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: Text(
                        service.detail ?? '-',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Text(
                        'เอกสารแนบ',
                        style: GoogleFonts.kanit(
                          textStyle: TextStyle(),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        for (var item in lsAttach)
                          InkWell(
                            onTap: () {
                              this._launchURL(item.remark);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.70,
                              child: Text(
                                item.name,
                                style: GoogleFonts.kanit(
                                  textStyle: TextStyle(
                                    color: Colors.orange,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget caseSummaryView() {
    return Container(
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
          titleform('สรุปผลพิจารณาเรื่อง / การวินิจฉัย'),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: Text(
                    service.summary ?? '-',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
            'เรื่องร้องเรียน',
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
                    caseStatusView(),
                    caseDetailView(),
                    caseSummaryView(),
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
