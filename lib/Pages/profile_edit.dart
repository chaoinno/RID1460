import 'package:RID1460/Utilities/global_resources.dart';
import 'package:RID1460/Utilities/nomal_dialog.dart';
import 'package:RID1460/models/account_detail.dart';
import 'package:RID1460/models/child_area.dart';
import 'package:RID1460/models/child_sub_area.dart';
import 'package:RID1460/models/province.dart';
import 'package:RID1460/models/web_api_result.dart';
import 'package:RID1460/models/zip_code.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
//Fields

//Variables
  String prefixName,
      firstName,
      lastName,
      nationalId,
      address,
      phoneNumber,
      postalCode,
      selectedGender,
      selectedSubDistrict,
      selectedDistrict,
      selectedProvince,
      sessionId;
  Account account;
  final fromkey = GlobalKey<FormState>();

  static List provinces, childAreas, subChildAreas;

  final titleController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final nationalIdController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final postalCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    provinces = [];
    childAreas = [];
    subChildAreas = [];
    account = Account();
    selectedGender = 'ชาย';
    readSharedPreferance();
  }

//Methods

  Future<void> readSharedPreferance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List userInfo = sharedPreferences.getStringList('UserInfo');
    print(userInfo);
    setState(() {
      sessionId = userInfo[6];
    });

    String url = GlobalResources().apiHost +
        'wcfrest.svc/getAccountDetail?sessionid=$sessionId';
    print(url);
    Dio dio = new Dio();
    try {
      Response response = await dio.get(url);
      var result = response.data;
      // print(result);
      AccountDetail autogenerated = AccountDetail.fromJson(result);
      // print(autogenerated.getAccountDetailResult);
      Map<dynamic, dynamic> map =
          jsonDecode(autogenerated.getAccountDetailResult);
      // print(map);
      GetAccountDetailResult getAccountDetailResult =
          GetAccountDetailResult.fromJson(map);
      print(getAccountDetailResult.account);

      if (getAccountDetailResult.result == 'error') {
        normalDialog(context, 'ผิดพลาด', getAccountDetailResult.msg);
      } else {
        setState(() {
          account = Account.fromJson(getAccountDetailResult.account);
          titleController.text = account.title ?? '-';
          firstNameController.text = account.firstname ?? '-';
          lastNameController.text = account.lastname ?? '-';
          selectedGender = account.gender ?? 'ชาย';
          nationalIdController.text = account.citizenid ?? '-';
          addressController.text = account.address ?? '-';
          selectedProvince = account.province ?? '';
          parseProvinces(
              GlobalResources().apiHost + 'wcfrest.svc/GetProvinceName');
          if (selectedProvince != 'null') {
            parseChildAreas(GlobalResources().apiHost +
                'wcfrest.svc/GetDistrict?province_name=' +
                selectedProvince);
          }
          selectedDistrict = account.district ?? '';
          selectedSubDistrict = account.subdistrict ?? '';
          if (selectedSubDistrict != 'null') {
            parseSubChildAreas(GlobalResources().apiHost +
                'wcfrest.svc/GetSubdistrict?province_name=${selectedProvince}&district_name=${selectedDistrict}');
          }
          postalCodeController.text = account.zipcode ?? '-';
          phoneNumberController.text = account.phone ?? '-';
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> normalDialog(
      BuildContext context, String title, String massage) async {
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: showTitile(title, massage),
            actions: [
              okButton(context),
            ],
          );
        });
  }

  Future<void> updateProfiileProcess() async {
    String url = GlobalResources().apiHost +
        'wcfrest.svc/EditAccount?sessionid=${sessionId}&title=${prefixName}&firstname=${firstName}&lastname=${lastName}&gender=${selectedGender}&citizenid=${nationalId}&address=${address}&province=${selectedProvince}&district=${selectedDistrict}&subdistrict=${selectedSubDistrict}&zipcode=${postalCode}&tel=${phoneNumber}';
    print(url);
    Dio dio = new Dio();
    try {
      Response response = await dio.put(url);
      print(response);
      var result = response.data;
      WebApiResult collection =
          WebApiResult.fromJson(result, 'EditAccountResult');
      Map<dynamic, dynamic> map = jsonDecode(collection.collectionResult);
      CollectionResult collectionResult = CollectionResult.fromJson(map);
      if (collectionResult.result == 'error') {
        normalDialog(context, 'บันทึกข้อมูลไม่สำเร็จ', collectionResult.msg);
      } else {
        normalDialog(context, 'บันทึกข้อมูลสำเร็จ', collectionResult.msg);
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> parseProvinces(String url) async {
    Response response = await Dio().get(url);

    var result = response.data;
    //print(result);
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
    print(url);
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
    ChildSubArea collection = ChildSubArea.fromJson(result);
    Map<dynamic, dynamic> map = jsonDecode(collection.getChildSubAreaResult);

    GetChildSubAreaResult subChildAreaResults =
        GetChildSubAreaResult.fromJson(map);
    subChildAreas = [];
    for (var item in subChildAreaResults.value) {
      subChildAreas.add({
        "label": ChildSubAreaValue.fromJson(item).label,
        "value": ChildSubAreaValue.fromJson(item).value
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
    postalCodeController.text = zipcodeResults.value.toString();
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
        style: GoogleFonts.kanit(
            textStyle: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        )),
      )),
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
              controller: titleController,
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
                firstName = string.trim();
              },
              validator: (value) => value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
              decoration: InputDecoration(
                labelText: 'ชื่อ *',
                hintText: 'ชื่อ',
              ),
              controller: firstNameController,
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
              controller: lastNameController,
            ),
          ),
        ],
      ),
    );
  }

  Widget saveButton() {
    return InkWell(
      onTap: () {
        fromkey.currentState.save();
        updateProfiileProcess();
      },
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
            'บันทึกข้อมูล',
            style: GoogleFonts.kanit(
              textStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  setSelectedGenderRadio(String val) {
    setState(() {
      selectedGender = val;
    });
  }

  Widget genderForm() {
    return ButtonBar(
      alignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          value: 'ชาย',
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
          value: 'หญิง',
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
              controller: nationalIdController,
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
              controller: addressController,
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
              value: selectedProvince != 'null'
                  ? selectedProvince
                  : "--ไม่ระบุจังหวัด--",
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
                      'wcfrest.svc/GetDistrict?province_name=' +
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
                      'wcfrest.svc/GetSubdistrict?province_name=${selectedProvince}&district_name=${selectedDistrict}');
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
                      'wcfrest.svc/GetZipcodeByName?province_name=${selectedProvince}&district_name=${selectedDistrict}');
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
              controller: postalCodeController,
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
              controller: phoneNumberController,
            ),
          ),
        ],
      ),
    );
  }

//Method

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
            centerTitle: true,
            title: Text(
              "แก้ไขข้อมูลสมาชิก",
              style: GoogleFonts.kanit(),
            )),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
            Form(
              key: fromkey,
              child: Center(
                child: Column(
                  children: [
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            )
                          ]),
                      child: Center(
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
                      child: saveButton(),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
