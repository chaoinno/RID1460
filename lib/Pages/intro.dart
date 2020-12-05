import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authen.dart';
import 'bottom_nav_parent.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  var userInfo;

  void initState() {
    super.initState();
    readSharedPreferance();
  }

  Future<void> readSharedPreferance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userInfo = sharedPreferences.getStringList('UserInfo');
    print(userInfo);
    if (userInfo == null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.of(context, rootNavigator: true).pushReplacement(
                _createAuthenRoute(Authen()),
              ));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.of(context, rootNavigator: true).pushReplacement(
                _createAuthenRoute(BottomNavBarParent()),
              ));
    }
  }

  Route _createAuthenRoute(var pageRouteBuilder) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => pageRouteBuilder,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
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
