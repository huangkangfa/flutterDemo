import 'base_env.dart';

///线上环境
class OnLine implements BaseEnv {
  @override
  String getBaseUrl() {
    return "http://121.40.58.45:7701";
  }

  @override
  bool getDebug() {
    return false;
  }
}