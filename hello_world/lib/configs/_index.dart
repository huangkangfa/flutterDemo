///基础配置
class Config {
  static const appName = '江小鹿';
  static String token;
  static BaseEnv env = new OnLine();
}

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

//环境基类
abstract class BaseEnv {
  String getBaseUrl() {
    return '';
  }

  bool getDebug() {
    return false;
  }
}
