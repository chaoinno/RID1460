import 'dart:io';
import 'package:RID1460/Utilities/global_resources.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OfficerWebView extends StatefulWidget {
  @override
  OfficerWebViewState createState() => OfficerWebViewState();
}

class OfficerWebViewState extends State<OfficerWebView> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "สำหรับเจ้าหน้าที่",
            style: GoogleFonts.kanit(),
          )),
      body: Container(
        child: WebView(
          initialUrl: GlobalResources().apiHost + 'Login/Login.aspx',
        ),
      ),
    );
  }
}
