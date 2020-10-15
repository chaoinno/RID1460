import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  Widget titleform() {
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
        "เข้าสู่ระบบ",
        style: TextStyle(
            fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
      )),
    );
  }

  Widget emailForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            // margin: EdgeInsets.all(10),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/social-media (1).png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: TextFormField(
              decoration: InputDecoration(hintText: 'อีเมล'),
            ),
          ),
        ],
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            // margin: EdgeInsets.all(10),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/key.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: TextFormField(
              decoration: InputDecoration(hintText: 'รหัสผ่าน'),
            ),
          ),
        ],
      ),
    );
  }

  Widget loginButtom() {
    return InkWell(
      onTap: () {
        print("object");
      },
      child: Container(
        height: 30,
        width: MediaQuery.of(context).size.width * 0.7,
        // color: Colors.white,ß
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.orange,
                  Colors.orange[900],
                ])
            //color: Colors.blue,

            //border: Border.all(color:Colors.red),
            ),

        child: Center(
          child: Text(
            'เข้าสู่ระบบ',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Authen"),
      // ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.9,
            // color: Colors.white,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              //border: Border.all(color:Colors.red),
            ),
            child: Column(
              children: [
                titleform(),
                emailForm(),
                passwordForm(),
                loginButtom(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
