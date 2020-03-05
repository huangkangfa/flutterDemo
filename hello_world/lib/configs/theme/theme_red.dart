import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hello_world/configs/theme/base_theme.dart';

class ThemeOfRed extends BaseTheme {
  @override
  Color getBackgroundColor({isDark: false}) {
    return isDark ? Colors.grey[800] : Colors.white;
  }

  @override
  Brightness getBrightness({isDark: false}) {
    return isDark ? Brightness.dark : Brightness.light;
  }

  @override
  Color getDividerColor({isDark: false}) {
    return isDark ? Colors.grey[350] : Colors.white;
  }

  @override
  MaterialColor getMaterialColor({isDark: false}) {
    return isDark
        ? MaterialColor(
            0xFFF44336,
            <int, Color>{
              50: Color(0xFFFFEBEE),
              100: Color(0xFFFFCDD2),
              200: Color(0xFFEF9A9A),
              300: Color(0xFFE57373),
              400: Color(0xFFEF5350),
              500: Color(0xFFF44336), //主题色
              600: Color(0xFFE53935),
              700: Color(0xFFD32F2F),
              800: Color(0xFFC62828),
              900: Color(0xFFB71C1C),
            },
          )
        : MaterialColor(
            0xFFF44336,
            <int, Color>{
              50: Color(0xFFFFEBEE),
              100: Color(0xFFFFCDD2),
              200: Color(0xFFEF9A9A),
              300: Color(0xFFE57373),
              400: Color(0xFFEF5350),
              500: Color(0xFFF44336), //主题色
              600: Color(0xFFE53935),
              700: Color(0xFFD32F2F),
              800: Color(0xFFC62828),
              900: Color(0xFFB71C1C),
            },
          );
  }

  @override
  String getName() {
    return '红色主题';
  }

  @override
  Color getPrimaryColor({isDark: false}) {
    return isDark ? Color(0xFFF44336) : Color(0xFFF44336);
  }
}
