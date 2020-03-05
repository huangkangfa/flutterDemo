import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hello_world/configs/theme/base_theme.dart';

class ThemeOfJxl extends BaseTheme {
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
    return isDark ? Colors.grey[350] : Colors.grey[600];
  }

  @override
  MaterialColor getMaterialColor({isDark: false}) {
    return isDark
        ? MaterialColor(
            0XFF9CD4CD,
            <int, Color>{
              50: Color(0xFFE8F5E9),
              100: Color(0xFFC8E6C9),
              200: Color(0xFFA5D6A7),
              300: Color(0xFF81C784),
              400: Color(0xFF66BB6A),
              500: Color(0XFF9CD4CD), //主题色
              600: Color(0xFF43A047),
              700: Color(0xFF388E3C),
              800: Color(0xFF2E7D32),
              900: Color(0xFF1B5E20),
            },
          )
        : MaterialColor(
            0XFF9CD4CD,
            <int, Color>{
              50: Color(0xFFE8F5E9),
              100: Color(0xFFC8E6C9),
              200: Color(0xFFA5D6A7),
              300: Color(0xFF81C784),
              400: Color(0xFF66BB6A),
              500: Color(0XFF9CD4CD), //主题色
              600: Color(0xFF43A047),
              700: Color(0xFF388E3C),
              800: Color(0xFF2E7D32),
              900: Color(0xFF1B5E20),
            },
          );
  }

  @override
  String getName() {
    return '江小鹿主题';
  }

  @override
  Color getPrimaryColor({isDark: false}) {
    return isDark ? Color(0XFF9CD4CD) : Color(0XFF9CD4CD);
  }
}
