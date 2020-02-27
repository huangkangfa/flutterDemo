import 'package:flutter/material.dart';
import 'package:hello_world/widget/base_appbar.dart';

class ErrorPage extends StatefulWidget {
  ErrorPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ErrorPageState();
  }
}

class ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: backAppbar(context, "错误界面"),
      body: Center(child: Text('出错啦~')),
    );;
  }
}