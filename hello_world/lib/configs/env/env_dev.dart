import 'base_env.dart';

///开发环境
class Dev implements BaseEnv {
  @override
  String getBaseUrl() {
    return "http://121.40.119.140:7701";
  }

  @override
  bool getDebug() {
    return true;
  }
}