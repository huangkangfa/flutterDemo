import 'package:flutter/material.dart';

abstract class BaseTheme {

  ///深色还是浅色 用于手机的黑暗模式匹配
  Brightness getBrightness({bool isDark});

  ///备用主题颜色，如果没有设定primaryColor就使用该颜色
  MaterialColor getMaterialColor({bool isDark});

  ///主题颜色
  Color getPrimaryColor({bool isDark});

  ///背景色
  Color getBackgroundColor({bool isDark});

  ///分割线颜色
  Color getDividerColor({bool isDark});

  String getName();
}
