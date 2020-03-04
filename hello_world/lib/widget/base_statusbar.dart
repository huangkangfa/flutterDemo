import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarUtils {
  ///设置沉浸式跟字体颜色
  static setBarStatus(bool isDarkIcon,
      {Color color: Colors.transparent}) async {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: color,
          statusBarIconBrightness:
              isDarkIcon ? Brightness.dark : Brightness.light));
    }
  }
}
