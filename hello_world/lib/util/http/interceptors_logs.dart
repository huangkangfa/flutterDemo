import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';

import 'utils.dart';

class LogsInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    LogUtil.v("===============网络请求开始 >>> ${currentTimeMillis()}==================");
    LogUtil.v("请求 baseUrl：${options.baseUrl}");
    LogUtil.v("请求 url：${options.path}");
    LogUtil.v('请求头: ' + options.headers.toString());
    LogUtil.v('post参数: ' + options.data.toString());
    LogUtil.v('get参数: ' + options.queryParameters.toString());
    return options;
  }

  @override
  onResponse(Response response) {
    LogUtil.v("请求 response：${response?.toString() ?? 'null'}");
    LogUtil.v("===============网络请求结束 >>> ${currentTimeMillis()}==================");
    return response;
  }

  @override
  onError(DioError err) {
    LogUtil.e('请求异常: ' + err.toString());
    LogUtil.e('请求异常信息: ' + err.response?.toString());
    LogUtil.e("===============网络请求报错 >>> ${currentTimeMillis()}==================");
    return err;
  }
}
