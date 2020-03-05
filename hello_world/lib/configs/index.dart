import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hello_world/model/model_theme.dart';
import 'package:hello_world/redux/app_state.dart';
import 'package:hello_world/configs/theme/theme_jxl.dart';
import 'package:hello_world/redux/reducer/reducer_theme.dart';
import 'package:hello_world/widget/base_sp.dart';

import 'env/base_env.dart';
import 'env/env_online.dart';
import 'app_keys.dart';
import 'theme/base_theme.dart';
import 'theme/theme_red.dart';

///基础配置
class Config {
  static const appName = '江小鹿';
  static String token;
  static BaseEnv env = OnLine();
  static BaseTheme theme = ThemeOfJxl();

  static resetTheme(BuildContext context) {
    int index = SpUtil.getInt(AppKeys.THEME_INDEX, defValue: 0);
    switch (index) {
      case 1:
        theme = ThemeOfRed();
        break;
      default:
        theme = ThemeOfJxl();
    }
    StoreProvider.of<AppState>(context).dispatch(
        RefreshThemeAction(ThemeInfo(index: index, name: theme.getName())));
  }
}
