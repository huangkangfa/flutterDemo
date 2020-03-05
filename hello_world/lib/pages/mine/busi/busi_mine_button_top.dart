import 'package:flutter/material.dart';
import 'package:hello_world/configs/size.dart';
import 'package:hello_world/util/util_event.dart';
import 'package:hello_world/widget/base_event_stateful.dart';
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

class ButtonOfTopState extends EventStateful<ButtonOfTop, ButtonOfTopEvent> {
  bool flag = false;

  _onTap() {
    sendEvent(RefreshSliverListEvent(widget.tag, 'toTop'));
  }

  @override
  void initState() {
    super.initState();
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
  }

  @override
  void doThingsForEvent(ButtonOfTopEvent data) {
    if (data.tag == widget.tag) {
      switch (data.cmd) {
        case 'changeFlag':
          flag = data.flag ?? false;
          break;
      }
    }
  }
}

class ButtonOfTopEvent {
  String cmd;
  String tag;
  bool flag;

  ButtonOfTopEvent(this.tag, this.cmd, {this.flag});
}
