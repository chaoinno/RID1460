import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {

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
    );
  }
}
