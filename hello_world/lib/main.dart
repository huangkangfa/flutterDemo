import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hello_world/configs/_index.dart';
import 'package:hello_world/pages/page_error.dart';
import 'package:hello_world/pages/splash/page_splash.dart';
import 'package:hello_world/redux/app_state.dart';
import 'package:hello_world/widget/base_toast.dart';
import 'package:redux/redux.dart';

import 'configs/colors.dart';

void main() => runApp(MyApp());

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
      child: MaterialApp(
        onUnknownRoute: (RouteSettings setting) {
          String name = setting.name;
          showToast("onUnknownRoute:$name");
          return MaterialPageRoute(builder: (context) {
            return ErrorPage();
          });
        },
        title: Config.appName,
        debugShowCheckedModeBanner: false,  // 去掉调试模式的debug标签
        theme: ThemeData(
          primarySwatch: MyPrimarySwatch.primarySwatchColor,
        ),
        home: SplashPage(),
      ),
    );
  }
}
