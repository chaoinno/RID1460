import 'dart:convert';

import 'package:RID1460/Pages/news_detail.dart';
import 'package:RID1460/Utilities/global_resources.dart';
import 'package:RID1460/Utilities/nomal_dialog.dart';
import 'package:RID1460/models/broadcast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class News extends StatefulWidget {
  final int sessionId;
  News({Key key, this.sessionId}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();

  Widget build(BuildContext context) {
    return MaterialApp(
      home: News(),
    );
  }
}

class _NewsState extends State<News> {
  Map<int, bool> countToValue = <int, bool>{};

  String keyword;
  List<BroadcastList> broadcastList = List<BroadcastList>();

  @override
  void initState() {
    super.initState();
    getBroadcasts();
  }

// Methods
  Future<void> getBroadcasts() async {
    String url = GlobalResources().apiHost + 'wcfrest.svc/getBroadcast';
    print(url);
    Dio dio = new Dio();
    try {
      Response response = await dio.get(url);
      // print(response);
      var result = response.data;
      Broadcast autogenerated = Broadcast.fromJson(result);
      // print(autogenerated.getBroadcastResult);
      Map<dynamic, dynamic> map = jsonDecode(autogenerated.getBroadcastResult);
      // print(map);
      GetBroadcastResult getBroadcastResult = GetBroadcastResult.fromJson(map);
      print(getBroadcastResult.list);
      if (getBroadcastResult.result == 'error') {
        normalDialog(context, 'ผิดพลาด', getBroadcastResult.msg);
      } else {
        for (var item in getBroadcastResult.list) {
          BroadcastList list1 = BroadcastList.fromJson(item);
          broadcastList.add(list1);
          print(list1.title);
        }
      }
    } catch (e) {
      print(e);
    }
  }

// Widgets
  Widget searchKeywordForm() {
    return Container(
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextFormField(
              onSaved: (String string) {
                keyword = string;
              },
              decoration: InputDecoration(hintText: 'ค้นหา...'),
            ),
          ),
          Container(
            height: 40,
            width: 40,
            child: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
        ],
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
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              "ข่าวสาร",
              style: TextStyle(fontFamily: 'Kanit'),
            )),
        body: ListTileTheme(
          selectedColor: shrineBrown900,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bg1.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              children: [
                Container(
                  child: searchKeywordForm(),
                ),
                for (var item in broadcastList)
                  InkWell(
                    onTap: () {
                      MaterialPageRoute materialPageRoute = MaterialPageRoute(
                        builder: (BuildContext context) => NewsDetail(
                          id: item.id,
                          title: item.title,
                          detail: item.detail,
                          date: DateTime.now().toIso8601String(),
                        ),
                      );
                      Navigator.of(context).push(materialPageRoute);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Image.asset("images/RID-logo-cmyk-TH.png"),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: ListTile(
                              title: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                       item.title.length >30? item.title.substring(0,30):item.title.substring(0,item.title.length),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        maxLines: 2,
                                        
                                        softWrap: true,
                                      ),
                                    ],
                                  ), item.title.length >30? Row(
                                    children: [
                                      Text(
                                        item.title.length >30?  item.title.substring(30,item.title.length):"",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        maxLines: 2,
                                        
                                        softWrap: true,
                                      ),
                                    ],
                                  ):Container(),
                                ],
                              ),
                              isThreeLine: true,
                              subtitle: Text(
                                DateTime.now().toIso8601String(),
                                style: TextStyle(
                                  color: Colors.orange,
                                ),
                              ),
                              selected: false,
                              trailing: Container(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                          ),
                        ],
                      ),
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

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: _shrineColorScheme,
    accentColor: shrineBrown900,
    primaryColor: shrinePink100,
    buttonColor: shrinePink100,
    scaffoldBackgroundColor: shrineBackgroundWhite,
    cardColor: shrineBackgroundWhite,
    textSelectionColor: shrinePink100,
    errorColor: shrineErrorRed,
    buttonTheme: const ButtonThemeData(
      colorScheme: _shrineColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryIconTheme: _customIconTheme(base.iconTheme),
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: shrineBrown900);
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
        button: base.button.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: shrineBrown900,
        bodyColor: shrineBrown900,
      );
}

const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrinePink100,
  primaryVariant: shrineBrown900,
  secondary: shrinePink50,
  secondaryVariant: shrineBrown900,
  surface: shrineSurfaceWhite,
  background: shrineBackgroundWhite,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onBackground: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);

const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color(0xFFEAA4A4);

const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrineBrown600 = Color(0xFF7D4F52);

const Color shrineErrorRed = Color(0xFFC5032B);

const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;
