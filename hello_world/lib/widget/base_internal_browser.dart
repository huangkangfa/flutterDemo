import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_fai_webview/flutter_fai_webview.dart';
import 'package:hello_world/configs/_index.dart';
import 'package:hello_world/widget/base_appbar.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  WebViewPage(this.url, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WebViewPageState();
  }
}

class WebViewPageState extends State<WebViewPage> {
  FaiWebViewWidget _faiWebViewWidget;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    _faiWebViewWidget = FaiWebViewWidget(
        url: widget.url,
//        callback: (code, str, obj) {
//          log('code='+code.toString()+'  str='+str+' obj='+obj.toString());
//        },
        isLog: Config.env.getDebug());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppbar(context, ''),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
          _faiWebViewWidget
        ],
      ),
    );
  }

  reload() {
    _faiWebViewWidget.refresh();
  }

  loadJs(String js) {
    _faiWebViewWidget.loadJsMethod(js);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
