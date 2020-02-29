import 'package:dio/dio.dart';
import 'package:hello_world/configs/apis.dart';
import 'package:hello_world/model/model_product_type_entity.dart';
import 'package:hello_world/util/http/http.dart';
import 'package:hello_world/util/http/result_data.dart';

class MallDao {
  ///获取商城所有数据
  static Future<List<ModelProductTypeEntity>> getMallProductType(
      {CancelToken cancelToken}) async {
    ResultData resultData = await HttpManager.getInstance()
        .get(Apis.tradeClassification, {'pid': 0}, cancelToken: cancelToken);
    if (resultData == null) return [];
    List<ModelProductTypeEntity> data = [];
    for (int i = 0; i < resultData.result.length; i++) {
      data.add(ModelProductTypeEntity().fromJson(resultData.result[i]));
    }
    return data;
  }
}
