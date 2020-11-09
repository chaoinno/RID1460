import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Newcase extends StatefulWidget {
  final String title;

  const Newcase({Key key, this.title}) : super(key: key);
  @override
  _NewcaseState createState() => _NewcaseState();
}

class _NewcaseState extends State<Newcase> {
  String title;
  Future<void> readSharedPreferance() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      List<String> read = sharedPreferences.getStringList('User');
      String email = read[0];
      String password = read[1];
      print('================>' + email);
      print('================>' + password);
    } catch (e) {}
  }

  Future<void> getApi(String session, userid) async {
    String url =
        "http://1.179.246.34/OPPP_Test/webservice.asmx/checksession?sessionid=" +
            session +
            "&userid=" +
            userid;
    Dio dio = new Dio();
    try {
      Response response = await dio.get(url);
      var result = response.data;
      print(result);
    } catch (e) {}
  }

  @override
  void initState() {
    readSharedPreferance();
    getApi('104', '3');
    // TODO: implement initState
    title = widget.title;
    super.initState();
  }

  final List<String> _dropdownValues = ["GET", "DATA", "IN", "DATABASE"];

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
        appBar:
            AppBar(centerTitle: true, title: Text("แจ้งเรื่องร้องเรียนใหม่")),
        body: Center(
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("images/bg1.png"),
              fit: BoxFit.cover,
            )),
            child: ListView(
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 25,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)),
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Text("รายละเอียด",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                        //fontWeight: FontWeight.bold
                                      )),
                                )),
                            Container(
                              height: 10,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 5.0, left: 30.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("เบอร์โทรศัพท์",
                                          //textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold
                                          )),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("*",
                                          //textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.red,
                                            //fontWeight: FontWeight.bold
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 30.0, right: 30.0),
                              child: TextFormField(
                                onSaved: (String string) {},
                                decoration:
                                    InputDecoration(hintText: 'เบอร์โทรศัพท์'),
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 5.0, left: 30.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("ประเภทเรื่อง",
                                          //textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold
                                          )),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("*",
                                          //textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.red,
                                            //fontWeight: FontWeight.bold
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 30.0, right: 30.0),
                              child: DropdownButton(
                                // dropdownColor: Colors.grey,
                                items: _dropdownValues
                                    .map((value) => DropdownMenuItem(
                                          child: Text(value),
                                          value: value,
                                        ))
                                    .toList(),
                                onChanged: (String value) {
                                  setState(() {
                                    value = value;
                                  });
                                },
                                isExpanded: true,
                                hint: Text('ประเภทเรื่อง'),
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 5.0, left: 30.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("รายละเอียด",
                                          //textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold
                                          )),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("*",
                                          //textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.red,
                                            //fontWeight: FontWeight.bold
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 30.0, right: 30.0),
                              child: TextFormField(
                                onSaved: (String string) {},
                                decoration:
                                    InputDecoration(hintText: 'รายละเอียด'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 15.0,
                        ),
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)),
                                  color: Colors.blue,
                                ),
                                child: Center(
                                  child: Text("เอกสารแนบ (ถ้ามี)",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                        //fontWeight: FontWeight.bold
                                      )),
                                )),
                            Container(
                              margin: const EdgeInsets.only(top: 10.0),
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.grey,
                              ),
                              child: Center(
                                child: Text("เลือกไฟล์เอกสาร",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      //fontWeight: FontWeight.bold
                                    )),
                              ),
                            ),
                            Container(
                              height: 5.0,
                            ),
                            Container(
                              child: Center(
                                child: Text("FileName.file",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.grey,
                                      //fontWeight: FontWeight.bold
                                    )),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
            child: Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.orange,
          ),
          child: Center(
            child: Text("บันทึกเรื่อง",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  //fontWeight: FontWeight.bold
                )),
          ),
        )),
      ),
    );
  }
}
