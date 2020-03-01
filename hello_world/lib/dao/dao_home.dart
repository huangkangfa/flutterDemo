import 'package:dio/dio.dart';
import 'package:hello_world/configs/apis.dart';
import 'package:hello_world/model/model_banner_list_entity.dart';
import 'package:hello_world/model/model_item_activity_entity.dart';
import 'package:hello_world/model/model_item_icon_entity.dart';
import 'package:hello_world/model/model_item_shop_entity.dart';
import 'package:hello_world/util/http/http.dart';
import 'package:hello_world/util/http/result_data.dart';

class HomeDao {
  ///获取轮播图数据
  static Future<List<ModelBannerListData>> getHomeBanner(params,
      {CancelToken cancelToken}) async {
    ResultData resultData = await HttpManager.getInstance()
        .get(Apis.banner_home, params, cancelToken: cancelToken);
    if (resultData == null) return null;
    return ModelBannerListEntity().fromJson(resultData.result).data;
  }

  ///获取首页功能列表数据
  static Future<List<ModelItemIconEntity>> getHomeIcons(
      {CancelToken cancelToken}) async {
    ResultData resultData = await HttpManager.getInstance()
        .get(Apis.icon_list_home, null, cancelToken: cancelToken);
    if (resultData == null) return [];
    List<ModelItemIconEntity> data = [];
    for (int i = 0; i < resultData.result.length; i++) {
      data.add(ModelItemIconEntity().fromJson(resultData.result[i]));
    }
    return data;
  }

  ///获取首页活动列表数据
  static Future<List<ModelItemActivityEntity>> getHomeActivitys(
      {CancelToken cancelToken}) async {
    ResultData resultData = await HttpManager.getInstance()
        .get(Apis.activity_list_home, null, cancelToken: cancelToken);
    if (resultData == null) return [];
    List<ModelItemActivityEntity> data = [];
    for (int i = 0; i < resultData.result.length; i++) {
      data.add(ModelItemActivityEntity().fromJson(resultData.result[i]));
    }
    return data;
  }

  ///获取首页商户列表数据
  static Future<List<ModelItemShopEntity>> getHomeShops(params,
      {CancelToken cancelToken, bool isDistance}) async {
    ResultData resultData = await HttpManager.getInstance().get(
        isDistance
            ? Apis.shops_list_distance_home
            : Apis.shops_list_popularity_home,
        params,
        cancelToken: cancelToken);
    if (resultData == null) return [];
    List<ModelItemShopEntity> data = [];
    for (int i = 0; i < resultData.result.length; i++) {
      data.add(ModelItemShopEntity().fromJson(resultData.result[i]));
    }
    return data;
  }
}
