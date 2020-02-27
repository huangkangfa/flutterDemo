import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';

resultError(e){
  if (e.type == DioErrorType.CONNECT_TIMEOUT) {
    // It occurs when url is opened timeout.
    LogUtil.e("连接超时");
  } else if (e.type == DioErrorType.SEND_TIMEOUT) {
    // It occurs when url is sent timeout.
    LogUtil.e("请求超时");
  } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
    //It occurs when receiving timeout
    LogUtil.e("响应超时");
  } else if (e.type == DioErrorType.RESPONSE) {
    // When the server response, but with a incorrect status, such as 404, 503...
    LogUtil.e("出现异常 >>>> "+e.toString());
  } else if (e.type == DioErrorType.CANCEL) {
    // When the request is cancelled, dio will throw a error with this type.
    LogUtil.e("请求取消");
  } else {
    //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
    LogUtil.e("未知错误 >>>> "+e.toString());
  }
  return null;
}