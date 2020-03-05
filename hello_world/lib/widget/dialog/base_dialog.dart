import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello_world/configs/app_colors.dart';
import 'package:hello_world/util/util_route_jump.dart';
import 'package:hello_world/util/util_screen.dart';

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
                      pop<String>(context, obj: 'ok');
                    }
                  },
                  child: customLeft ?? Text(left ?? '确认'),
                ),
                FlatButton(
                  onPressed: () {
                    if (rightCallBack != null) {
                      rightCallBack();
                    } else {
                      pop<String>(context, obj: 'cancle');
                    }
                  },
                  child: customRight ?? Text(right ?? '取消'),
                ),
              ],
        );
      });
}

///通用底部弹框
showActionsSheet(BuildContext context,
    {Widget customWidget,
    List<ActionsSheetData> data,
    bool hasCancle: true,
    ShapeBorder shape}) {
  double height = 0;
  List<Widget> cds = [];
  if (data != null && data.length > 0) {
    height += data.length * 50;
    for (int i = 0; i < data.length; i++) {
      cds.add(Expanded(
          flex: 1,
          child: GestureDetector(
            child: Container(
              color: AppColors.TRANSPARENT,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text(data[i].name, textAlign: TextAlign.center)]),
            ),
            onTap: () {
              if (data[i].callback != null) {
                data[i].callback();
              } else {
                pop<String>(context, obj: data[i].name);
              }
            },
          )));
    }
  }
  if (hasCancle) {
    height += 50;
    cds.add(Expanded(
        flex: 1,
        child: GestureDetector(
          child: Container(
            color: AppColors.TRANSPARENT,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text('取消', textAlign: TextAlign.center)]),
          ),
          onTap: () {
            pop<String>(context, obj: 'cancle');
          },
        )));
  }

  showModalBottomSheet(
      context: context,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(ScreenUtil().setWidth(8)),
              topRight: Radius.circular(ScreenUtil().setWidth(8)),
            ),
          ),
      builder: (BuildContext context) {
        return customWidget ??
            Container(
              height: height,
              child: Column(
                children: cds,
              ),
            );
      });
}

//通用底部弹框关联数据
class ActionsSheetData {
  String name;
  Function callback;

  ActionsSheetData({@required this.name, this.callback});
}
