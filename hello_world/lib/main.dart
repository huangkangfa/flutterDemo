import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hello_world/configs/index.dart';
import 'package:hello_world/model/model_theme.dart';
import 'package:hello_world/pages/page_error.dart';
import 'package:hello_world/pages/splash/page_splash.dart';
import 'package:hello_world/redux/app_state.dart';
import 'package:hello_world/widget/dialog/base_dialog.dart';
import 'package:redux/redux.dart';

import 'widget/base_statusbar.dart';

void main() {
  StatusBarUtils.setBarStatus(true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /// 创建Store，引用 AppState 中的 appReducer 创建 Reducer
  /// initialState 初始化 State
  final store = Store<AppState>(appReducer,
      initialState: AppState(
        userInfo: null,
      ));

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///初始化日志
    LogUtil.init(isDebug: Config.env.getDebug(), tag: Config.appName);

    /// 通过 StoreProvider 应用 store
    return StoreProvider(
      store: store,
      child: StoreConnector<AppState, ThemeInfo>(
        converter: (store) => store.state.themeInfo,
        builder: (context, themeInfo) {
          Config.resetTheme(context);
          return MaterialApp(
            onUnknownRoute: (RouteSettings setting) {
              String name = setting.name;
              showToast("onUnknownRoute:$name");
              return MaterialPageRoute(builder: (context) {
                return ErrorPage();
              });
            },
            title: Config.appName,
            // 去掉调试模式的debug标签
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Config.theme.getBrightness(),
              primarySwatch: Config.theme.getMaterialColor(),
              backgroundColor: Config.theme.getBackgroundColor(),
            ),
//        darkTheme: ThemeData(
//          brightness: Config.theme.getBrightness(true),
//          primarySwatch: Config.theme.getMaterialColor(true),
//          backgroundColor: Config.theme.getBackgroundColor(true),
//        ),
            home: SplashPage(),
          );
        },
      ),
    );
  }
}
