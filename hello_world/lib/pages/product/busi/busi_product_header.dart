import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_appbar.dart';

class ProductHeader extends StatefulWidget {

  ProductHeader({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductHeaderState();
  }
}

class ProductHeaderState extends State<ProductHeader> {
  StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription = registerEvent<ProductHeaderEvent>((data) {
      if (data is ProductHeaderEvent) {

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 48
      ),
      child: backActionAppbar(context,'',Text('右边'),backgroundColor:Colors.red),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

}

class ProductHeaderEvent {
  String cmd;

  ProductHeaderEvent(this.cmd);
}