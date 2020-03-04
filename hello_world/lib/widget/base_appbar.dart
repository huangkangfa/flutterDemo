import 'package:flutter/material.dart';
import 'package:hello_world/util/util_screen.dart';

double adapt(double w) {
  return w;
}

double sp(num) {
  return ScreenUtil().setSp(num);
}

///左侧返回按钮、中间标题
backAppbar(BuildContext context, String title,
    {Function tapFunc, Color backgroundColor, Color textColor}) {
  return PreferredSize(
      preferredSize: Size.fromHeight(adapt(48)),
      child: AppBar(
        elevation: 0,
        backgroundColor:
            backgroundColor == null ? Colors.white : backgroundColor,
        leading: _leading(context),
        title: GestureDetector(
          child: Text(
            title,
            style: TextStyle(
                fontSize: sp(22),
                color: textColor == null ? Color(0xFF000000) : textColor),
          ),
          onTap: () {
            tapFunc();
          },
        ),
        centerTitle: true,
      ));
}

///左侧返回按钮、中间标题、右侧自定义
backActionAppbar(BuildContext context, String title, Widget action,
    {Function backFunc, Color backgroundColor, Color textColor}) {
  return PreferredSize(
      preferredSize: Size.fromHeight(adapt(48)),
      child: AppBar(
        elevation: 0,
        backgroundColor:
            backgroundColor == null ? Colors.white : backgroundColor,
        leading: _leading(context, backFunc: backFunc),
        title: GestureDetector(
          child: Text(
            title,
            style: TextStyle(
                fontSize: sp(18),
                color: textColor == null ? Color(0xFF000000) : textColor),
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              action,
            ],
          ),
        ],
      ));
}

///左侧自定义、中间标题、右侧自定义
baseAppbar(BuildContext context, String title, Widget leading, Widget action,
    {Color backgroundColor, Color textColor}) {
  return PreferredSize(
      preferredSize: Size.fromHeight(adapt(48)),
      child: AppBar(
        elevation: 0,
        backgroundColor:
            backgroundColor == null ? Colors.white : backgroundColor,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[leading],
        ),
        title: GestureDetector(
          child: Text(
            title,
            style: TextStyle(
                fontSize: sp(18),
                color: textColor == null ? Color(0xFF000000) : textColor),
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              action,
            ],
          ),
        ],
      ));
}

///完全自定义
comAppbar(BuildContext context,
    {Widget appBar,
    Widget left,
    Widget center,
    Widget right,
    Color backgroundColor,
    bool top}) {
  if (appBar == null) {
    List<Widget> list = [];
    if (left != null) list.add(left);
    if (center != null)
      list.add(Expanded(
        flex: 1,
        child: center,
      ));
    if (right != null) list.add(right);
    appBar = Row(children: list);
  }
  return PreferredSize(
      preferredSize: Size.fromHeight(adapt(48)),
      child: SafeArea(
        top: top ?? true,
        child: Container(
          color: backgroundColor == null ? Colors.white : backgroundColor,
          height: adapt(48),
          alignment: Alignment.center,
          child: appBar,
        ),
      ));
}

///返回按钮控件
_leading(BuildContext context, {Function backFunc}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        width: adapt(41),
        padding: EdgeInsets.all(0),
        child: IconButton(
          padding: EdgeInsets.only(left: adapt(10), right: adapt(20)),
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (backFunc == null) {
              _popThis(context);
            } else {
              backFunc();
            }
          },
        ),
      ),
    ],
  );
}

void _popThis(BuildContext context) {
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  }
}
