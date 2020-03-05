import 'package:flutter/material.dart';
import 'package:hello_world/configs/app_keys.dart';
import 'package:hello_world/configs/app_size.dart';
import 'package:hello_world/navigator/navigator.dart';
import 'package:hello_world/util/util_route_jump.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_sp.dart';

import 'busi/busi_timedown.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  bool hasAd = false;

  @override
  void initState() {
    super.initState();
    _initSplash();
  }

  void _initSplash() async {
    await SpUtil.getInstance();
    if(this.mounted){
      setState(() {
        hasAd = SpUtil.getBool(AppKeys.SWITCH_AD, defValue: true);
        if (!hasAd) {
          _goMain();
        }
      });
    }
  }

  void _goMain() {
    reset(context, MyNavigator());
  }

  @override
  Widget build(BuildContext context) {
    //屏幕适配 设置宽度750px，高度1334px，根据系统字体进行缩放
    ScreenUtil.init(context, width: 375, height: 667, allowFontScaling: false);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
          Visibility(
            visible: hasAd,
            child: Image.asset('images/bg_ad.jpg', fit: BoxFit.cover),
          ),
          Visibility(
            visible: hasAd,
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right:AppSize.marginSizeMax,top: ScreenUtil().setHeight(45)),
                child: SplashTimeDown(() {
                  _goMain();
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
