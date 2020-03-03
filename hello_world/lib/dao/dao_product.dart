import 'package:dio/dio.dart';
import 'package:hello_world/configs/apis.dart';
import 'package:hello_world/model/model_product_entity.dart';
import 'package:hello_world/util/http/http.dart';
import 'package:hello_world/util/http/result_data.dart';

class ProductDao {
  ///获取商品详情数据
  static Future<ModelProductEntity> getProductDetail(params,
      {CancelToken cancelToken}) async {
    ResultData resultData = await HttpManager.getInstance()
        .get(Apis.products_detail, params, cancelToken: cancelToken);
    if (resultData == null) return null;
    return ModelProductEntity().fromJson(resultData.result);
  }
}
