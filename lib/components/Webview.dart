
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebview extends HookWidget {
  String webview;

  MyWebview(this.webview);

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepOrange, toolbarHeight: 10,),
      body: WebView(
        initialUrl: webview, 
        javascriptMode: JavascriptMode.unrestricted, 
        gestureNavigationEnabled: true,
      )
    );
  }
}