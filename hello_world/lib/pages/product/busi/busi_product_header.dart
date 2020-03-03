import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello_world/util/util_event.dart';

class ProductHeader extends StatefulWidget {

  ProductHeader({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ProductHeaderState();
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
    return null;
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