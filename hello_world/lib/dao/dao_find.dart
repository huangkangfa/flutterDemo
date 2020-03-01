import 'package:dio/dio.dart';
import 'package:hello_world/configs/apis.dart';
import 'package:hello_world/model/model_find_index_entity.dart';
import 'package:hello_world/util/http/http.dart';
import 'package:hello_world/util/http/result_data.dart';

class FindDao {

  ///获取发现页功能列表数据
  static Future<List<ModelFindIndexEntity>> getFindIndexs(
      {CancelToken cancelToken}) async {
    ResultData resultData = await HttpManager.getInstance()
        .get(Apis.selectIndexServerCategoryList, null, cancelToken: cancelToken);
    if (resultData == null) return [];
    List<ModelFindIndexEntity> data = [];
    for (int i = 0; i < resultData.result.length; i++) {
      data.add(ModelFindIndexEntity().fromJson(resultData.result[i]));
    }
    return data;
  }

}
