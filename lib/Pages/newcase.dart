import 'package:flutter/material.dart';

class Newcase extends StatefulWidget {
  @override
  _NewcaseState createState() => _NewcaseState();
}

class _NewcaseState extends State<Newcase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Container(
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/home-icon-silhouette.png"),
              height: 25,
              width: 25,
            ),
            label : 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/interface.png"),
              height: 25,
              width: 25,
            ),
             label : 'ประวัติการแจ้งเรื่อง',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/tools-and-utensils.png"),
              height: 25,
              width: 25,
            ),
             label : 'ข่าวสาร',
          ),
        ],
      ),
    );
  }
}
