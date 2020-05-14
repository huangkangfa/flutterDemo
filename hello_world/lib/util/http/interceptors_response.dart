import 'package:dio/dio.dart';
import 'package:hello_world/configs/index.dart';
import 'package:hello_world/util/http/result_data.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    if (Config.token != null) {
      options.headers['token'] = Config.token;
    }
    return options;
  }

  @override
  onResponse(Response response) {
    RequestOptions option = response.request;
    try {
      if (option.contentType != null &&
          option.contentType.primaryType == 'text') {
        return getResultDataFromResponse(response, success: true, code: 0);
      }

      ///一般只需要处理200的情况，300、400、500保留错误信息
      if (response.statusCode == 200 || response.statusCode == 201) {
        return getResultDataFromResponse(response);
      } else if (response.statusCode == 401) {
        //重新登录处理
        Config.token = null;
        
      }
    } catch (e) {
      return getResultDataFromResponse(response,
          success: false, code: response.statusCode, error: e.toString());
    }

    return getResultDataFromResponse(response,
        success: false, code: response.statusCode);
  }

  @override
  onError(DioError err) {
    return err;
  }

  getResultDataFromResponse(Response response, {result, success, code, error}) {
    return new ResultData(
        result ?? response.data['result'],
        success ?? response.data['success'],
        code ?? response.data['code'],
        error ?? response.data['error'],
        headers: response.headers);
  }
}
