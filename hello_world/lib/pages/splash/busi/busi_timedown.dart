import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/configs/app_size.dart';
import 'package:hello_world/util/util_screen.dart';

class SplashTimeDown extends StatefulWidget {
  final Function callback;
  final int timeDown;

  SplashTimeDown(this.callback, {Key key, this.timeDown}) : super(key: key);

  @override
  _SplashTimeDownState createState() => _SplashTimeDownState();
}

class _SplashTimeDownState extends State<SplashTimeDown> {
  TimerUtil _timerUtil;

  int timeDown = 5;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    if(this.mounted){
      setState(() {
        if (widget.timeDown != null) {
          timeDown = widget.timeDown;
        }
        _doCountDown();
      });
    }
  }

  void _doCountDown() {
    _timerUtil = TimerUtil(mTotalTime: timeDown * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      if(this.mounted){
        setState(() {
          timeDown = _tick.toInt();
        });
      }
      if (_tick == 0) {
        if (widget.callback != null) {
          widget.callback();
        }
      }
    });
    _timerUtil.startCountDown();
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: GestureDetector(
            onTap: () {
              if (widget.callback != null) {
                if (_timerUtil != null) _timerUtil.cancel();
                widget.callback();
              }
            },
            child: Container(
              color: Color(0x99000000),
              height: ScreenUtil().setWidth(60),
              width: ScreenUtil().setWidth(60),
              child: Center(
                  child: Text('跳过${timeDown}s', style: TextStyle(
                      color: Colors.white, fontSize: AppSize.fontSize14)),
              ),
            )
        ));
  }

  @override
  void dispose() {
    super.dispose();
    if (_timerUtil != null) _timerUtil.cancel(); //记得在dispose里面把timer cancel。
  }
}
