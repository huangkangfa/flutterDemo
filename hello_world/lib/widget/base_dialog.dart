import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///toast取消
cancelToast() {
  Fluttertoast.cancel();
}

///toast显示
showToast(msg) {
  cancelToast();
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      fontSize: 16.0);
}

///通用提示框  上文本  下按钮的那种
showPromptDialog(BuildContext context,
    {String title: '',
    String content: '',
    String left,
    String right,
    Widget customLeft,
    Widget customRight,
    Widget customTitle,
    Widget customContent,
    List<Widget> customActions,
    Function leftCallBack,
    Function rightCallBack}) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: customTitle ?? Text(title),
          content: customContent ?? Text(content),
          actions: customActions ??
              [
                FlatButton(
                  onPressed: () {
                    if (leftCallBack != null) {
                      leftCallBack();
                    } else {
                      Navigator.of(context).pop("ok");
                    }
                  },
                  child: customLeft ?? Text(left ?? '确认'),
                ),
                FlatButton(
                  onPressed: () {
                    if (rightCallBack != null) {
                      rightCallBack();
                    } else {
                      Navigator.of(context).pop("cancle");
                    }
                  },
                  child: customRight ?? Text(right ?? '取消'),
                ),
              ],
        );
      });
}
