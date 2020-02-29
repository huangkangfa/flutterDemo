///接口名管理
class Apis {
  ///登录接口
  static const login = '/api/auth/login';

  ///轮播图
  static const banner_home = '/api/ucenter/disBanner';

  ///首页功能bar
  static const icon_list_home = '/api/trade/indexIcon/selectIndexIconList';

  ///首页商品列表
  static const products_home = '/api/trade/trade/selectIndexProduct';

  ///首页活动列表
  static const activity_list_home =
      '/api/trade/indexActivity/selectIndexActivityList';

  ///按照距离获取商户信息
  static const shops_list_distance_home = '/api/trade/recommend/distance';

  ///商城列表数据
  static const tradeClassification = '/api/trade/tradeClassification/listClassIficationByParentId';
}
