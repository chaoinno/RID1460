import 'dart:convert';
import 'dart:io';

import 'package:RID1460/Utilities/global_resources.dart';
import 'package:RID1460/Utilities/nomal_dialog.dart';
import 'package:RID1460/models/account_detail.dart';
import 'package:RID1460/models/category.dart';
import 'package:RID1460/models/web_api_result.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Newcase extends StatefulWidget {
  final String title;
  const Newcase({Key key, this.title}) : super(key: key);
  @override
  _NewcaseState createState() => _NewcaseState();
}

class _NewcaseState extends State<Newcase> {
  //fields
  File _image;
  final fromkey = GlobalKey<FormState>();
  String fullName,
      email,
      sessionId,
      idCardNo,
      address,
      province,
      district,
      subdistrict,
      postalCode,
      phoneNumber,
      detail,
      categoryName;
  int categoryId;
  GetCategoryResult selectedCategory;
  static List categories;
  @override
  void initState() {
    categories = [];
    readSharedPreferance();
    parseCategories(GlobalResources().apiHost + 'wcfrest.svc/GetCategory');
    super.initState();
  }

  //methods
  Future<void> readSharedPreferance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List userInfo = sharedPreferences.getStringList('UserInfo');
    print(userInfo);
    setState(() {
      email = userInfo[0];
      sessionId = userInfo[6];
    });
    getAccountDetails();
  }

  Future<void> getAccountDetails() async {
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
      // print(getAccountDetailResult.account);
      Account account = Account.fromJson(getAccountDetailResult.account);

      if (getAccountDetailResult.result == 'error') {
        normalDialog(context, 'ผิดพลาด', getAccountDetailResult.msg);
      } else {
        setState(() {
          this.fullName = account.firstname + ' ' + account.lastname;
          this.idCardNo = account.citizenid ?? '-';
          this.address = account.address ?? '-';
          this.province = account.province ?? '-';
          this.district = account.district ?? '-';
          this.subdistrict = account.subdistrict ?? '-';
          this.postalCode = account.zipcode ?? '-';
          this.phoneNumber = account.phone ?? '-';
        });
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> parseCategories(String url) async {
    // print(url);
    Response response = await Dio().get(url);
    // print(response);
    var result = response.data;
    // print(result);
    Category collection = Category.fromJson(result);
    Map<dynamic, dynamic> map = jsonDecode(collection.getCategoryResult);
    // print(map);

    GetCategoryResult categoryResults = GetCategoryResult.fromJson(map);
    categories = [];
    for (var item in categoryResults.value) {
      print(item);
      categories.add(item);
    }
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> addServiceProcess() async {
    String url = GlobalResources().apiHost + 'wcfrest.svc/addService';
    print(url);
    Dio dio = new Dio();
    var param = {
      "sessionid": sessionId,
      "phone": phoneNumber,
      "category_id": categoryId,
      "category_text": categoryName,
      "detail": detail
    };
    String paramJson = jsonEncode(param);
    print(paramJson);
    try {
      Response response = await dio.post(url,
          data: paramJson,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));
      print(response);
      var result = response.data;
      WebApiResult collection =
          WebApiResult.fromJson(result, 'addServiceResult');
      Map<dynamic, dynamic> map = jsonDecode(collection.collectionResult);
      CollectionResult collectionResult = CollectionResult.fromJson(map);
      if (collectionResult.result == 'error') {
        normalDialog(context, 'แจ้งเรื่องไม่สำเร็จ', collectionResult.msg);
      } else {
        normalDialog(context, 'แจ้งเรื่องสำเร็จ', collectionResult.msg);
        // Navigator.of(context).pop();
      }
    } catch (e) {
      print(e);
    }
  }

  //widgets

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

  Widget serviceTypeListViewForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: DropDownFormField(
              titleText: 'ประเภทเรื่อง *',
              hintText: 'ประเภทเรื่อง',
              value: categoryId,
              onSaved: (value) {
                setState(() {
                  categoryId = value;
                  categoryName = "ร้องเรียน";
                });
              },
              onChanged: (newvalue) {
                setState(() {
                  categoryId = newvalue;
                  categoryName = "ร้องเรียน";
                  // selectedCategory = categories.firstWhere((element) => newvalue);
                  // print(selectedCategory);
                });
              },
              dataSource: categories,
              textField: 'label',
              valueField: 'value',
            ),
          ),
        ],
      ),
    );
  }

  Widget detailForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 3,
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: 16,
              maxLength: 512,
              maxLengthEnforced: true,
              autofocus: false,
              onSaved: (String string) {
                detail = string.trim();
              },
              validator: (value) => value.isEmpty ? 'กรุณากรอกข้อมูล' : null,
              decoration: InputDecoration(
                labelText: 'รายละเอียด *',
                hintText: 'รายละเอียด',
              ),
            ),
          ),
        ],
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

  Widget saveButton() {
    return InkWell(
      onTap: () {
        fromkey.currentState.save();
        addServiceProcess();
        // print(selectedCategory);
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
            'บันทึกเรื่อง',
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

  Widget imagePicker() {
    return Container(
      child: GestureDetector(
        onTap: () {
          _showPicker(context);
        },
        child: CircleAvatar(
          radius: 55,
          backgroundColor: Color(0xffFDCF09),
          child: _image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    _image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50)),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
        ),
      ),
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
        //appBar: AppBar(centerTitle: true, title: Text("$title")),
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              "แจ้งเรื่องร้องเรียนใหม่",
              style: GoogleFonts.kanit(),
            )),
        body: Center(
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("images/bg1.png"),
              fit: BoxFit.cover,
            )),
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
                              titleform("รายละเอียด"),
                              SizedBox(width: 10.0),
                              serviceTypeListViewForm(),
                              SizedBox(width: 10.0),
                              detailForm(),
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              )
                            ]),
                        child: Center(
                          child: Column(
                            children: [
                              titleform("เอกสารแนบ (ถ้ามี)"),
                              imagePicker(),
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
      ),
    );
  }
}
