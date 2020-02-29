import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/widget/base_refresh_sliver_list.dart';
import 'package:hello_world/widget/widget_button_to_top.dart';

class ButtonOfTop extends StatefulWidget {
  final String tag;

  ButtonOfTop(this.tag, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new ButtonOfTopState();
  }
}

class ButtonOfTopState extends State<ButtonOfTop> {
  StreamSubscription _streamSubscription;
  bool flag = false;

  _onTap() {
    sendEvent(RefreshSliverListEvent(widget.tag, 'toTop'));
  }

  @override
  void initState() {
    super.initState();
    _streamSubscription = registerEvent<ButtonOfTopEvent>((data) {
      if (data is ButtonOfTopEvent && data.tag == widget.tag) {
        if (data.cmd == 'changeFlag') {
          flag = data.flag ?? false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: flag,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.all(ThemeSize.marginSizeMax),
          child: StackToTop(onTap: () {
            _onTap();
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }
}

class ButtonOfTopEvent {
  String cmd;
  String tag;
  bool flag;

  ButtonOfTopEvent(this.tag, this.cmd, {this.flag});
}
