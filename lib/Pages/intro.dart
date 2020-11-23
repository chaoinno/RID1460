import 'dart:async';
import 'package:RID1460/Pages/authen.dart';
import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {

  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Authen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("images/bg2.png"),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.075,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/RID-logo-cmyk-TH.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
