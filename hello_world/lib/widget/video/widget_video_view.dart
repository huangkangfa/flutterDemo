import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tencentplayer/controller/tencent_player_controller.dart';
import 'package:flutter_tencentplayer/flutter_tencentplayer.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/util/util_screen.dart';

import 'widget_video_control.dart';

class VideoView extends StatefulWidget {
  final String url;
  final int startTime;
  final bool isPause;
  final Function currentPrograss;
  final Function playStatus;

  VideoView(
      {@required this.url,
      this.isPause,
      this.startTime,
      @required this.currentPrograss,
      @required this.playStatus,
      Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return VideoViewState();
  }
}

class VideoViewState extends State<VideoView> {
  StreamSubscription _streamSubscription;
  TencentPlayerController _controller;
  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    initVideo(true);
    _streamSubscription = registerEvent<VideoViewEvent>((data) {
      if (!this.mounted) {
        return;
      }
      if (data is VideoViewEvent && data != null && _controller != null) {
        switch (data.cmd) {
          //播放
          case 'play':
            if (_controller.value.position.inSeconds >=
                _controller.value.duration.inSeconds) {
              _controller.seekTo(Duration(seconds: 0));
            }
            _controller.play();
            if (widget.playStatus != null) {
              widget.playStatus(false);
            }
            break;
          //暂停
          case 'pause':
            _controller.pause();
            if (widget.playStatus != null) {
              widget.playStatus(true);
            }
            break;
          //跳转进度
          case 'seekTo':
            _controller.seekTo(Duration(seconds: data.obj.toInt() ?? 0));
            break;
          //设置播放速度
          case 'setRate':
            _controller.setRate(data.obj.toDouble() ?? 1.0); // 1.0 ~ 2.0
            break;
          //切换播放源
          case 'changeUrl':
            _controller.removeListener(listener);
            _controller.pause();
            _controller = TencentPlayerController.network(data.url ?? '',
                playerConfig: PlayerConfig(startTime: 0));
            _controller.initialize().then((_) {
              if (mounted) setState(() {});
            });
            _controller.addListener(listener);
            break;
        }
      }
    });
  }

  void initVideo(bool flag) {
    if (flag) {
      _controller = TencentPlayerController.network(widget.url,
          playerConfig: PlayerConfig(
              autoPlay: !(widget.isPause ?? false),
              loop: true,
              progressInterval: 1000,
              startTime: widget.startTime ?? 0));
      _controller.initialize();
      listener = () {
        if (!mounted) {
          return;
        }
//        print('\n');
//        print('是否初始化完成从而显示播放器 >>>>> ' + _controller.value.initialized.toString());
//        print('用来控制播放器宽高比 >>>>> ' + _controller.value.aspectRatio.toString());
//        print('时长 >>>>> ' + _controller.value.duration.inSeconds.toString());
//        print('播放进度 >>>>> ' + _controller.value.position.inSeconds.toString());
//        print('缓冲进度 >>>>> ' + _controller.value.playable.inSeconds.toString());
//        print('是否在播放 >>>>> ' + _controller.value.isPlaying.toString());
//        print('视频宽高 >>>>> ' + _controller.value.size.toString());
//        print('是否在加载 >>>>> ' + _controller.value.isLoading.toString());
//        print('视频播放网速 >>>>> ' + _controller.value.netSpeed.toString());
//        print('播放速度 >>>>> ' + _controller.value.rate.toString());
//        print('视频清晰度 >>>>> ' + _controller.value.bitrateIndex.toString());
//        print('\n');
        sendEvent(VideoControlEvent('endTime',
            obj: _controller.value.duration.inSeconds));
        sendEvent(VideoControlEvent('startTime',
            obj: _controller.value.position.inSeconds));
        if (widget.currentPrograss != null) {
          if (_controller.value.position.inSeconds >=
              _controller.value.duration.inSeconds) {
            widget.currentPrograss(0);
          } else {
            widget.currentPrograss(_controller.value.position.inSeconds);
          }
        }
        setState(() {});
      };
      _controller.addListener(listener);
    } else {
      _controller.removeListener(listener);
      _controller.dispose();
    }
  }

  @override
  void dispose() {
    super.dispose();
    initVideo(false);
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.initialized
          ? Stack(
              children: <Widget>[
                AspectRatio(
                  aspectRatio:
                      ScreenUtil.screenWidthDp / ScreenUtil().setWidth(300),
                  child: TencentPlayer(_controller),
                ),
                VideoControl(isShow: widget.isPause)
              ],
            )
          : Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class VideoViewEvent {
  String cmd;
  num obj;
  String url;

  VideoViewEvent(this.cmd, {this.obj, this.url});
}
