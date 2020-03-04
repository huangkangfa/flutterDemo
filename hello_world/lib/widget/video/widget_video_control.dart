import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello_world/configs/colors.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/util/http/utils.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_screen.dart';

import 'widget_video_view.dart';

class VideoControl extends StatefulWidget {
  final bool isShow;

  VideoControl({@required this.isShow, Key key}) : super(key: key);

  @override
  _VideoControlState createState() => _VideoControlState();
}

class _VideoControlState extends State<VideoControl> {
  StreamSubscription _streamSubscription;
  bool isShow = false;
  String startTime = '00:00';
  int _startTime = 0;
  String endTime = '00:00';
  int _endTime = 0;
  int lastChangeSliderPrograss = 0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    sendEvent(VideoViewEvent(isShow ? 'play' : 'pause'));
                    isShow = !isShow;
                  });
                },
                child: Container(
                  color: Color(0x00000000),
                  width: ScreenUtil().setWidth(200),
                  padding: EdgeInsets.all(ThemeSize.marginSizeMid),
                  margin: EdgeInsets.only(top: ScreenUtil().setWidth(25)),
                  child: Visibility(
                    visible: isShow,
                    child: Icon(Icons.play_circle_outline,
                        size: ScreenUtil().setWidth(60), color: Colors.white),
                  ),
                )),
          ),
          Container(
            height: ScreenUtil().setWidth(50),
            padding: EdgeInsets.only(
                left: ThemeSize.marginSizeMid,
                right: ThemeSize.marginSizeMid,
                top: ThemeSize.marginSizeMid),
            child: Row(
              children: <Widget>[
                Text(startTime,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ThemeSize.fontSize14,
                        shadows: <Shadow>[
                          Shadow(color: Colors.black26, offset: Offset(0, 1)),
                        ])),
                Expanded(
                  flex: 1,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 5.0,
                      ),
                      overlayShape: RoundSliderOverlayShape(
                        overlayRadius: 3.0,
                      ),
                    ),
                    child: Slider(
                      value: _startTime.toDouble(),
                      max: _endTime.toDouble(),
                      min: 0,
                      activeColor: ThemeColors.primary,
                      onChanged: (val) {
                        setState(() {
                          _startTime = val.toInt();
                          startTime = getTimeStrBySeconds(_startTime);
                          int now = currentTimeMillis();
                          if (now - lastChangeSliderPrograss > 500) {
                            sendEvent(
                                VideoViewEvent('seekTo', obj: _startTime));
                            lastChangeSliderPrograss = now;
                          }
                        });
                      },
                    ),
                  ),
                ),
                Text(endTime,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ThemeSize.fontSize14,
                        shadows: <Shadow>[
                          Shadow(color: Colors.black26, offset: Offset(0, 1)),
                        ]))
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    isShow = widget.isShow ?? false;
    _streamSubscription = registerEvent<VideoControlEvent>((data) {
      if (!this.mounted) {
        return;
      }
      if (data is VideoControlEvent && data != null) {
        switch (data.cmd) {
          case 'startTime':
            setState(() {
              _startTime = data.obj ?? 0;
              startTime = getTimeStrBySeconds(data.obj);
            });
            break;
          case 'endTime':
            setState(() {
              _endTime = data.obj ?? 0;
              endTime = getTimeStrBySeconds(data.obj);
            });
            break;
        }
      }
    });
  }

  getTimeStrBySeconds(int seconds) {
    if (seconds == null) return '00:00';
    int a = (seconds.toDouble() / 60).floor().toInt();
    int b = seconds % 60;
    String result = '';
    if (a < 10) {
      result += '0';
    }
    result += a.toString() + ':';
    if (b < 10) {
      result += '0';
    }
    result += b.toString();
    return result;
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }
}

class VideoControlEvent {
  String cmd;
  int obj;

  VideoControlEvent(this.cmd, {this.obj});
}
