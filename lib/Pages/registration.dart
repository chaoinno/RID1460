import 'package:RID1460/Utilities/global_resources.dart';
import 'package:RID1460/models/child_area.dart';
import 'package:RID1460/models/province.dart';
import 'package:RID1460/models/zip_code.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
//Fields
  TextEditingController zipcodeController = new TextEditingController();

//Variables

  String email,
      password,
      confirmPassword,
      prefixName,
      firstName,
      lastName,
      nationalId,
      address,
      phoneNumber,
      postalCode;
  final fromkey = GlobalKey<FormState>();
  int selectedGender;
  String selectedSubDistrict, selectedDistrict, selectedProvince;

  static List provinces, childAreas, subChildAreas;

  @override
  void initState() {
    provinces = [];
    childAreas = [];
    subChildAreas = [];

    parseProvinces(
        GlobalResources().apiHost + 'OPPP_Test/wcfrest.svc/GetProvince');

    super.initState();
    selectedGender = 1;
  }

//Methods

  Future<void> registerProcess() async {
    Navigator.of(context).pop();
  }

  static Future<void> parseProvinces(String url) async {
    Response response = await Dio().get(url);

    var result = response.data;
    Province collection = Province.fromJson(result);
    Map<dynamic, dynamic> map = jsonDecode(collection.getProvinceResult);

    GetProvinceResult provinceResults = GetProvinceResult.fromJson(map);
    provinces = [];
    for (var item in provinceResults.value) {
      provinces.add({
        "label": ProvinceValue.fromJson(item).label,
        "value": ProvinceValue.fromJson(item).value
      });
    }
  }

  static Future<void> parseChildAreas(String url) async {
    Response response = await Dio().get(url);

    var result = response.data;
    ChildArea collection = ChildArea.fromJson(result);
    Map<dynamic, dynamic> map = jsonDecode(collection.getChildAreaResult);

    GetChildAreaResult childAreaResults = GetChildAreaResult.fromJson(map);
    childAreas = [];
    for (var item in childAreaResults.value) {
      childAreas.add({
        "label": ChildAreaValue.fromJson(item).label,
        "value": ChildAreaValue.fromJson(item).value
      });
    }
  }

  static Future<void> parseSubChildAreas(String url) async {
    Response response = await Dio().get(url);

    var result = response.data;
    ChildArea collection = ChildArea.fromJson(result);
    Map<dynamic, dynamic> map = jsonDecode(collection.getChildAreaResult);

    GetChildAreaResult subChildAreaResults = GetChildAreaResult.fromJson(map);
    subChildAreas = [];
    for (var item in subChildAreaResults.value) {
      subChildAreas.add({
        "label": ChildAreaValue.fromJson(item).label,
        "value": ChildAreaValue.fromJson(item).value
      });
    }
  }

  void parseZipCode(String url) async {
    print(url);
    Response response = await Dio().get(url);
    var result = response.data;
    Zipcode collection = Zipcode.fromJson(result);
    Map<dynamic, dynamic> map = jsonDecode(collection.getZipcodeResult);

    GetZipcodeResult zipcodeResults = GetZipcodeResult.fromJson(map);
    print(zipcodeResults.value);
    postalCode = zipcodeResults.value.toString();
    zipcodeController.text = zipcodeResults.value.toString();
  }

//Widgets

  Widget logo() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/RID-logo-cmyk-TH.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget titleform(String title) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
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
        title,
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
          SizedBox(width: 15.0),
          Flexible(
            flex: 3,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              onSaved: (String string) {
                email = string.trim();
              },
              validator: (value) => value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
              decoration: InputDecoration(
                labelText: 'อีเมล (ID) *',
                hintText: 'user@mail.com',
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
                labelText: 'รหัสผ่าน *',
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
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              onSaved: (String string) {
                confirmPassword = string.trim();
              },
              validator: (value) =>
                  value.length < 6 ? 'รหัสผ่านไม่น้อยกว่า 6 ตัวอักษร' : null,
              decoration: InputDecoration(
                labelText: 'ยืนยันรหัสผ่าน *',
                hintText: 'รหัสผ่าน',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget prefixNameForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 3,
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.text,
              onSaved: (String string) {
                prefixName = string.trim();
              },
              validator: (value) => value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
              decoration: InputDecoration(
                labelText: 'คำนำหน้าชื่อ *',
                hintText: 'นาย / นางสาว / นาง / ฯลฯ',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget firstNameForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.38,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 3,
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.text,
              onSaved: (String string) {
                prefixName = string.trim();
              },
              validator: (value) => value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
              decoration: InputDecoration(
                labelText: 'ชื่อ *',
                hintText: 'ชื่อ',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget lastNameForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.39,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 3,
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.text,
              onSaved: (String string) {
                lastName = string.trim();
              },
              validator: (value) => value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
              decoration: InputDecoration(
                labelText: 'นามสกุล *',
                hintText: 'นามสกุล',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget registerButton() {
    return InkWell(
      onTap: () {
        registerProcess();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
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
            'ลงทะเบียน',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget facebookButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
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
            'ลงทะเบียนด้วย FACEBOOK',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  setSelectedGenderRadio(int val) {
    setState(() {
      selectedGender = val;
    });
  }

  Widget genderForm() {
    return ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          value: 1,
          groupValue: selectedGender,
          activeColor: Colors.orange,
          onChanged: (val) {
            print("Radio $val");
            setSelectedGenderRadio(val);
          },
        ),
        Text(
          'ชาย',
          style: new TextStyle(
            fontSize: 17.0,
          ),
        ),
        Radio(
          value: 2,
          groupValue: selectedGender,
          activeColor: Colors.orange,
          onChanged: (val) {
            print("Radio $val");
            setSelectedGenderRadio(val);
          },
        ),
        Text(
          'หญิง',
          style: new TextStyle(
            fontSize: 17.0,
          ),
        ),
      ],
    );
  }

  Widget nationalIdForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 3,
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.number,
              onSaved: (String string) {
                nationalId = string.trim();
              },
              validator: (value) => value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
              decoration: InputDecoration(
                labelText: 'รหัสประจำตัวประชาชน *',
                hintText: 'รหัสประจำตัวประชาชน 13 หลัก',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget addressForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 3,
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.text,
              onSaved: (String string) {
                address = string.trim();
              },
              validator: (value) => value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
              decoration: InputDecoration(
                labelText: 'ที่อยู่ *',
                hintText: 'บ้านเลขที่ / ซอย / หมู่ / ถนน',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget provinceListViewForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20),
            child: DropDownFormField(
              titleText: 'จังหวัด *',
              hintText: 'จังหวัด',
              value: selectedProvince,
              onSaved: (value) {
                setState(() {
                  selectedProvince = value;
                });
              },
              onChanged: (newvalue) {
                setState(() {
                  selectedProvince = newvalue;
                  selectedDistrict = null;
                  parseChildAreas(GlobalResources().apiHost +
                      'OPPP_Test/wcfrest.svc/GetChildArea?ref_id=' +
                      selectedProvince);
                });
              },
              dataSource: provinces,
              textField: 'label',
              valueField: 'value',
            ),
          ),
        ],
      ),
    );
  }

  Widget districtListViewForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5),
            child: DropDownFormField(
              titleText: 'อำเภอ *',
              hintText: 'อำเภอ',
              value: selectedDistrict,
              onSaved: (value) {
                setState(() {
                  selectedDistrict = value;
                });
              },
              onChanged: (newvalue) {
                setState(() {
                  selectedDistrict = newvalue;
                  selectedSubDistrict = null;
                  parseSubChildAreas(GlobalResources().apiHost +
                      'OPPP_Test/wcfrest.svc/GetChildArea?ref_id=' +
                      selectedDistrict);
                });
              },
              dataSource: childAreas,
              textField: 'label',
              valueField: 'value',
            ),
          ),
        ],
      ),
    );
  }

  Widget subDistrictListViewForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20),
            child: DropDownFormField(
              titleText: 'ตำบล *',
              hintText: 'ตำบล',
              value: selectedSubDistrict,
              onSaved: (value) {
                setState(() {
                  selectedSubDistrict = value;
                });
              },
              onChanged: (newvalue) {
                setState(() {
                  selectedSubDistrict = newvalue;
                  parseZipCode(GlobalResources().apiHost +
                      'OPPP_Test/wcfrest.svc/GetZipcode?id=' +
                      selectedDistrict);
                });
              },
              dataSource: subChildAreas,
              textField: 'label',
              valueField: 'value',
            ),
          ),
        ],
      ),
    );
  }

  Widget postalCodeForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.39,
      padding: EdgeInsets.only(left: 5, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 3,
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              onSaved: (String string) {
                postalCode = string.trim();
              },
              validator: (value) => value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
              decoration: InputDecoration(
                labelText: 'รหัสไปรษณีย์ *',
                hintText: 'รหัสไปรษณีย์',
              ),
              controller: zipcodeController,
            ),
          ),
        ],
      ),
    );
  }

  Widget phoneNumberForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 3,
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              onSaved: (String string) {
                phoneNumber = string.trim();
              },
              validator: (value) => value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
              decoration: InputDecoration(
                labelText: 'เบอร์โทรศัพท์ *',
                hintText: 'เบอร์โทรศัพท์',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loginApi() async {
    String url = '';
    Dio dio = new Dio();
    Response response = await dio.post(
      url,
      data: {
        "email": email,
        "password": password,
      },
      //options:  Options(contentType: Headers.formUrlEncodedContentType)
    );

    var result = response.data;
    //ถ้าข้อมูลList
  }

  Future<void> saveSharePerence() async {
    List<String> list = List();
    list.add(email);
    list.add(password);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('User', list);
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
        appBar: AppBar(centerTitle: true, title: Text("ลงทะเบียนสมาชิก")),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
            Center(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: facebookButton(),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 20.0),
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
                          titleform("ข้อมูลเข้าใช้ระบบ"),
                          emailForm(),
                          passwordForm(),
                          confirmPasswordForm(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    padding: const EdgeInsets.only(bottom: 20.0),
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
                        ]),
                    child: Form(
                      child: Column(
                        children: [
                          titleform("ข้อมูลสมาชิก"),
                          prefixNameForm(),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                              children: [
                                firstNameForm(),
                                SizedBox(width: 10.0),
                                lastNameForm()
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10.0),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              'เพศ *',
                              style: new TextStyle(
                                color: Colors.black45,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          genderForm(),
                          nationalIdForm(),
                          addressForm(),
                          Container(
                            child: Row(
                              children: [
                                provinceListViewForm(),
                                districtListViewForm(),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                subDistrictListViewForm(),
                                postalCodeForm(),
                              ],
                            ),
                          ),
                          phoneNumberForm(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: registerButton(),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
