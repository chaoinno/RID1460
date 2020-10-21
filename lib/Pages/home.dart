import 'dart:ui';

import 'package:RID1460/Pages/contact.dart';
import 'package:RID1460/Pages/newcase.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget logo() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/RID-logo-cmyk-TH.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget newCaseItem() {
    return InkWell(
      //borderRadius: BorderRadius.circular(10.0),
      onTap: () {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Newcase());
        Navigator.of(context).push(materialPageRoute);
      },
      child: Container(
        child: Image.asset(
          "images/home-btn1.png",
          width: MediaQuery.of(context).size.width * 0.95,

        ),
      ),
    );
  }

  Widget historyANDnewsItem() {
    return InkWell(
        // borderRadius: BorderRadius.circular(10.0),
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            //MaterialPageRoute materialPageRoute =
            //MaterialPageRoute(builder: (BuildContext context) => );
            //Navigator.of(context).push(materialPageRoute);
          },
          child: Container(
            child: Image.asset(
              "images/home-btn3.png",
              width: MediaQuery.of(context).size.width * 0.47,
            ),
          ),
        ),
        Container(
          width: 5.0,
        ),
        InkWell(
          onTap: () {
            //MaterialPageRoute materialPageRoute =
            //MaterialPageRoute(builder: (BuildContext context) => );
            //Navigator.of(context).push(materialPageRoute);
          },
          child: Container(
            child: Image.asset(
              "images/home-btn4.png",
              width: MediaQuery.of(context).size.width * 0.47,
            ),
          ),
        ),
      ],
    ));
  }

  Widget contactItem() {
    return InkWell(
      // borderRadius: BorderRadius.circular(10.0),
      onTap: () {
        MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => Contact());
        Navigator.of(context).push(materialPageRoute);
      },
      child: Container(
        child: Image.asset(
          "images/home-btn2.png",
          width: MediaQuery.of(context).size.width * 0.95,
        ),
      ),
    );
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Newcase());
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 40,
            ),
            logo(),
            Container(
              height: 20,
            ),
            newCaseItem(),
            Container(
              height: 5,
            ),
            historyANDnewsItem(),
            Container(
              height: 5,
            ),
            contactItem(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage("images/home-icon-silhouette.png"),
              height: 25,
              color: Colors.orange,
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
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
      ),
    );
  }
}
