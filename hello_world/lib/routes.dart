import 'package:hello_world/navigator/navigator.dart';
import 'package:hello_world/pages/page_error.dart';
import 'package:hello_world/pages/page_splash.dart';

///注册路由
initRoutes() {
  return {
    RouteName.SCREEN_MAIN: (context) => new MyNavigator(),
    RouteName.SCREEN_SPLASH: (context) => new SplashPage(),
    RouteName.SCREEN_ERROR: (context) => new ErrorPage(),
  };
}

class RouteName {
  ///首页
  static const SCREEN_MAIN = '/screen_main';

  ///启动页
  static const SCREEN_SPLASH = '/screen_splash';

  ///错误页
  static const SCREEN_ERROR = '/screen_error';
}
