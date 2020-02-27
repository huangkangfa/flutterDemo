//颜色管理
import 'package:flutter/material.dart';

class ThemeColors {
  //主题色
  static const Color colorPrimary =
      Color(MyPrimarySwatch._primarySwatchColorValue);
  //字体相关
  static const Color colorFont_333 = Color(0xFF333333);
  static const Color colorFont_666 = Color(0xFF666666);
  static const Color colorFont_999 = Color(0xFF999999);
  static const Color colorFontHint = Color(0XFFBCBCBC);
  static const Color colorBg_EEECEC = Color(0xFFEEECEC);
}

//自定义主题色-颜色的集合
class MyPrimarySwatch extends MaterialColor {
  MyPrimarySwatch(int primary, Map<int, Color> swatch) : super(primary, swatch);

  static const MaterialColor primarySwatchColor = MaterialColor(
    _primarySwatchColorValue,
    <int, Color>{
      50: Color(0xFFE8F5E9),
      100: Color(0xFFC8E6C9),
      200: Color(0xFFA5D6A7),
      300: Color(0xFF81C784),
      400: Color(0xFF66BB6A),
      500: Color(_primarySwatchColorValue),
      600: Color(0xFF43A047),
      700: Color(0xFF388E3C),
      800: Color(0xFF2E7D32),
      900: Color(0xFF1B5E20),
    },
  );
  static const int _primarySwatchColorValue = 0XFF9CD4CD;
}
