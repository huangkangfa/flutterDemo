import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_route_jump.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_appbar.dart';
import 'package:hello_world/widget/base_toast.dart';

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
      if (data is ProductHeaderEvent) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: ScreenUtil().setWidth(70)),
      child: baseAppbar(
          context,
          '',
          GestureDetector(
            onTap: () => pop(context),
            child: Padding(
              padding: EdgeInsets.only(
                  left: ThemeSize.marginSizeMid),
              child: ClipOval(
                  child: Container(
                      color: Color(0x30000000),
                      child: Padding(
                        padding: EdgeInsets.all(ThemeSize.marginSizeMin),
                        child: Icon(Icons.arrow_back_ios,
                            color: Colors.white, size: ThemeSize.fontSize20),
                      ))),
            ),
          ),
          GestureDetector(
              onTap: () => showToast('分享'),
              child: Padding(
                padding: EdgeInsets.only(
                    right: ThemeSize.marginSizeMid),
                child: ClipOval(
                    child: Container(
                        color: Color(0x30000000),
                        child: Padding(
                          padding: EdgeInsets.all(ThemeSize.marginSizeMin),
                          child: Icon(Icons.share,
                              size: ThemeSize.fontSize20, color: Colors.white),
                        ))),
              )),
          backgroundColor: ThemeColors.transparent),
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
