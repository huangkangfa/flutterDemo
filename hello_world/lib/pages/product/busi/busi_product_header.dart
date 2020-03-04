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
  bool isShowHeader = false;

  @override
  void initState() {
    super.initState();
    _streamSubscription = registerEvent<ProductHeaderEvent>((data) {
      if (data is ProductHeaderEvent && data != null) {
        switch (data.cmd) {
          case 'isShowHeader':
            setState(() {
              isShowHeader = data.flag ?? false;
            });
            break;
        }
      }
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
              padding: EdgeInsets.only(left: ThemeSize.marginSizeMid),
              child: ClipOval(
                  child: Container(
                      color: Color(isShowHeader ? 0x00000000 : 0x30000000),
                      child: Padding(
                        padding: EdgeInsets.all(ThemeSize.marginSizeMin),
                        child: Icon(Icons.arrow_back_ios,
                            color: isShowHeader ? Colors.black : Colors.white,
                            size: ThemeSize.fontSize20),
                      ))),
            ),
          ),
          GestureDetector(
              onTap: () => showToast('分享'),
              child: Padding(
                padding: EdgeInsets.only(right: ThemeSize.marginSizeMid),
                child: ClipOval(
                    child: Container(
                        color: Color(isShowHeader ? 0x00000000 : 0x30000000),
                        child: Padding(
                          padding: EdgeInsets.all(ThemeSize.marginSizeMin),
                          child: Icon(Icons.share,
                              size: ThemeSize.fontSize20,
                              color:
                                  isShowHeader ? Colors.black : Colors.white),
                        ))),
              )),
          backgroundColor:
              isShowHeader ? Colors.white : ThemeColors.transparent),
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
  bool flag;

  ProductHeaderEvent(this.cmd, {this.flag});
}
