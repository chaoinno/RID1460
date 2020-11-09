import 'dart:ui';

import 'package:RID1460/Pages/authen.dart';
import 'package:RID1460/Pages/contact.dart';
import 'package:RID1460/Pages/newcase.dart';
import 'package:RID1460/Pages/news.dart';
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
            MaterialPageRoute materialPageRoute =
                MaterialPageRoute(builder: (BuildContext context) => News());
            Navigator.of(context).push(materialPageRoute);
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
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
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
          ],
        ),
      ),
    );
  }
}
