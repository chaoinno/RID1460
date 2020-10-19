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

  Future<void> getApi(String id) async {
    String url = "http://203.113.14.18/TestApi/api/Employee/Get/" + id;
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
    getApi('1');
    // TODO: implement initState
    title = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(centerTitle: true, title: Text("${widget.title}แจ้งเรื่องร้องเรียนใหม่ $title")),
      appBar: AppBar(centerTitle: true, title: Text("แจ้งเรื่องร้องเรียนใหม่")),
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("images/bg1.png"),
            fit: BoxFit.cover,
          )),
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 25,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.07,
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
                    ],
                  ),
                ),
                Container(
                  height: 25,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.07,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: Container(
          child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.9,
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/home-icon-silhouette.png"),
              height: 25,
              //width: 25,
            ),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/interface.png"),
              height: 25,
              width: 25,
            ),
            label: 'ประวัติการแจ้งเรื่อง',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/writing (1).png"),
              height: 25,
              color: Colors.black,
              //width: 25,
            ),
            label: 'แจ้งเรื่องร้องเรียนใหม่',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/tools-and-utensils.png"),
              height: 25,
              // width: 25,
            ),
            label: 'ข่าวสาร',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/more.png"),
              height: 25,
              // width: 25,
            ),
            label: 'เพิ่มเติม',
          ),
        ],
      ),
    );
  }
}
