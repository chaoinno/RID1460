import 'package:RID1460/Pages/home.dart';
import 'package:RID1460/Pages/newcase.dart';
import 'package:RID1460/Pages/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Home());
        Navigator.of(context).push(materialPageRoute);
      } else if (index == 2) {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Newcase());
        Navigator.of(context).push(materialPageRoute);
      } else if (index == 3) {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => News());
        Navigator.of(context).push(materialPageRoute);
      }
      //MaterialPageRoute materialPageRoute =
      // MaterialPageRoute(builder: (BuildContext context) => Authen());
      //Navigator.of(context).pop();
      //Navigator.of(context).push(materialPageRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("ติดต่อเรา")),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: Column(
            children: [
              Container(
                height: 25,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
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
                        child: Text(
                            "กองส่งเสริมการมีส่วนร่วมของประชาชนกรมชลประทาน",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.white,
                              //fontWeight: FontWeight.bold
                            )),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0, left: 30.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("อาคารศูนย์วิศวกรรมการชลประทานชั้น 1",
                            //textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[800],
                              //fontWeight: FontWeight.bold
                            )),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("811 ถ.สามเสน แขวงถนนนครไชยศรี เขตดุสิต",
                            //textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[800],
                              //fontWeight: FontWeight.bold
                            )),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("กรุงเทพฯ 10300",
                            //textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[800],
                              //fontWeight: FontWeight.bold
                            )),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0, left: 30.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("โทร. 0-2669-3775",
                            //textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[800],
                              //fontWeight: FontWeight.bold
                            )),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("หมายเลขภายใน 2825",
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[800],
                              //fontWeight: FontWeight.bold
                            )),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("แฟกซ์ 0-2669-1460",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[800],
                              //fontWeight: FontWeight.bold
                            )),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: Image.asset(
                          "images/map.png",
                          width: MediaQuery.of(context).size.width * 0.85,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/home-icon-silhouette.png"),
              height: 25,
              //width: 25,
            ),
            title: Text('หน้าหลัก'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/interface.png"),
              height: 25,
              width: 25,
            ),
            title: Text('ประวัติการแจ้งเรื่อง'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/writing (1).png"),
              height: 25,
              color: Colors.grey,
              //width: 25,
            ),
            title: Text('แจ้งเรื่องร้องเรียนใหม่'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/tools-and-utensils.png"),
              height: 25,
              // width: 25,
            ),
            title: Text('ข่าวสาร'),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/more.png"),
              height: 25,
              color: Colors.grey,
              // width: 25,
            ),
            title: Text('เพิ่มเติม'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
