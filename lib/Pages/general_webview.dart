import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GeneralWebView extends StatefulWidget {
  final String url;
  GeneralWebView({Key key, this.url}) : super(key: key);

  @override
  GeneralWebViewState createState() => GeneralWebViewState();
}

class GeneralWebViewState extends State<GeneralWebView> {
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
          initialUrl: widget.url,
        ),
      ),
    );
  }
}
