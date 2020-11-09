import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String oldPassword, password, confirmPassword;
  final fromkey = GlobalKey<FormState>();

  Widget submitButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.orange,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )
          ],
        ),
        child: Center(
          child: Text(
            'ตั้งรหัสผ่านใหม่',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget oldPasswordForm() {
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
          SizedBox(width: 15.0),
          Flexible(
            flex: 3,
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.text,
              onSaved: (String string) {
                password = string.trim();
              },
              validator: (value) =>
                  value.length < 1 ? 'ระบุรหัสผ่านเดิม' : null,
              decoration: InputDecoration(
                labelText: 'รหัสผ่านเดิม *',
                hintText: 'รหัสผ่าน',
              ),
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
          SizedBox(width: 15.0),
          Flexible(
            flex: 3,
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.text,
              onSaved: (String string) {
                password = string.trim();
              },
              validator: (value) =>
                  value.length < 6 ? 'รหัสผ่านไม่น้อยกว่า 6 ตัวอักษร' : null,
              decoration: InputDecoration(
                labelText: 'รหัสผ่านใหม่ *',
                hintText: 'รหัสผ่าน',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget confirmPasswordForm() {
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
          SizedBox(width: 15.0),
          Flexible(
            flex: 3,
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.visiblePassword,
              onSaved: (String string) {
                confirmPassword = string.trim();
              },
              validator: (value) =>
                  value != password ? 'ยืนยันรหัสผ่านไม่ถูกต้อง' : null,
              decoration: InputDecoration(
                labelText: 'ยืนยันรหัสผ่านใหม่ *',
                hintText: 'รหัสผ่าน',
              ),
            ),
          ),
        ],
      ),
    );
  }

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
        "ระบุรหัสผ่าน",
        style: TextStyle(
            fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
      )),
    );
  }

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
        appBar: AppBar(
          title: Text('เปลี่ยนรหัสผ่าน'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 15),
                  margin: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      )
                    ],
                  ),
                  child: Form(
                    key: fromkey,
                    child: Column(
                      children: [
                        titleform(),
                        oldPasswordForm(),
                        passwordForm(),
                        confirmPasswordForm(),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      submitButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
