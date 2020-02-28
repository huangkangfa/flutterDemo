import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/keys.dart';
import 'package:hello_world/util/util_screen.dart';
import 'package:hello_world/widget/base_sp.dart';
import 'package:hello_world/widget/base_statusbar.dart';

import '../routes.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  TimerUtil _timerUtil;

  int timeDown = 3;

  bool hasAd = false;

  @override
  void initState() {
    super.initState();
    _initSplash();
  }

  void _initSplash() async {
    await SpUtil.getInstance();
    setState(() {
      hasAd = SpUtil.getBool(Keys.SWITCH_AD,defValue: true);
      if (hasAd) {
        _doCountDown();
      } else {
        _goMain();
      }
    });
  }

  void _doCountDown() {
    _timerUtil = TimerUtil(mTotalTime: 3 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        timeDown = _tick.toInt();
      });
      if (_tick == 0) {
        _goMain();
      }
    });
    _timerUtil.startCountDown();
  }

  void _goMain() {
    Navigator.of(context).pushReplacementNamed(RouteName.SCREEN_MAIN);
  }

  @override
  Widget build(BuildContext context) {
    //设置沉浸式
    StatusBarUtils.setBarStatus(true);
    //屏幕适配 设置宽度750px，高度1334px，根据系统字体进行缩放
    ScreenUtil.init(context, width: 375, height: 667, allowFontScaling: false);
    return Scaffold(
      body: Center(child: Text(hasAd?'我是广告页 倒计时：$timeDown s':'即将进入...')),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timerUtil != null) _timerUtil.cancel(); //记得在dispose里面把timer cancel。
  }
}
