import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:hello_world/configs/index.dart';

import 'http_error.dart';
import 'interceptors_logs.dart';
import 'interceptors_response.dart';

class HttpManager {
  static HttpManager _instance = HttpManager._internal();

  Dio _dio, dioDownload, dioUpload;

  // 工厂模式 : 单例公开访问点
  factory HttpManager() => _instance;

  ///通用全局单例，第一次使用时初始化
  HttpManager._internal() {
    if (null == _dio) {
      _dio = new Dio(new BaseOptions(
          //请求基地址,可以包含子路径
          baseUrl: Config.env.getBaseUrl(),
          //连接服务器超时时间，单位是毫秒.
          connectTimeout: 10000,
          //响应流上前后两次接受到数据的间隔，单位为毫秒。
          receiveTimeout: 5000,
          //Http请求头.
          headers: {},
          //请求的Content-Type，默认值是[ContentType.json]. 也可以用ContentType.parse("application/x-www-form-urlencoded")
          contentType: ContentType.json,
          //表示期望以那种格式(方式)接受响应数据。接受4种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
          responseType: ResponseType.json));

//      ///假设我们的后台服务使用的是自签名证书，证书格式是PEM格式，我们将证书的内容保存在本地字符串中，那么我们的校验逻辑如下
//      String PEM="XXXXX"; // certificate content
//      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
//        client.badCertificateCallback=(X509Certificate cert, String host, int port){
//          if(cert.pem==PEM){ // Verify the certificate
//            return true;
//          }
//          return false;
//        };
//      };
//      ///对于自签名的证书，我们也可以将其添加到本地证书信任链中，这样证书验证时就会自动通过，而不会再走到badCertificateCallback回调中
//      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
//        SecurityContext sc = new SecurityContext();
//        //file is the path of certificate
//        sc.setTrustedCertificates(file);
//        HttpClient httpClient = new HttpClient(context: sc);
//        return httpClient;
//      };

      _dio.interceptors.add(new LogsInterceptors());
      _dio.interceptors.add(CookieManager(CookieJar()));
      _dio.interceptors.add(new ResponseInterceptors());
    }
  }

  static HttpManager getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名，比如cdn和kline首次的http请求
  HttpManager _baseUrl(String baseUrl) {
    if (_dio != null) {
      _dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般请求，默认域名
  HttpManager _normal() {
    if (_dio != null) {
      if (_dio.options.baseUrl != Config.env.getBaseUrl()) {
        _dio.options.baseUrl = Config.env.getBaseUrl();
      }
    }
    return this;
  }

  ///通用的GET请求
  get(url, params, {cancelToken}) async {
    Response response;
    try {
      response = await _dio.get(url,
          queryParameters: params, cancelToken: cancelToken);
    } on DioError catch (e) {
      return resultError(e);
    }

    if (response is DioError) {
      return resultError(response);
    }

    return response.data;
  }

  ///通用的POST请求
  post(url, params, {cancelToken}) async {
    Response response;

    try {
      response = await _dio.post(url, data: params, cancelToken: cancelToken);
    } on DioError catch (e) {
      return resultError(e);
    }

    if (response is DioError) {
      return resultError(response);
    }

    return response.data;
  }

  /*
   * 下载文件
   */
  download(urlPath, savePath, {cancelToken}) async {
    Response response;
    try {
      if (null == dioDownload) {
        dioDownload = new Dio();
        dioDownload.interceptors.add(CookieManager(CookieJar()));
      }
      response = await dioDownload.download(urlPath, savePath,
          cancelToken: cancelToken, onReceiveProgress: (int count, int total) {
        LogUtil.v("文件下载进度 >>>>>> $count $total");
      });
      LogUtil.v('文件下载 success---------${response.data}');
    } on DioError catch (e) {
      LogUtil.e('文件下载 error---------$e');
      resultError(e);
    }
    return response.data;
  }

  ///上传文件
  ///
  /// 图片上传参数转换示例
  ///
  /// 1.获取文件名及格式
  /// String path1 = _image1.path;
  /// var name1 = path1.substring(path1.lastIndexOf("/") + 1, path1.length);
  /// String suffix1 = name1.substring(name1.lastIndexOf(".") + 1, name1.length);
  ///
  /// 2.调用上传方法（参数转化很重要）
  /// var data = {
  ///   'loadingFile': UploadFileInfo(
  ///       new File(path1),
  ///       name1,
  ///       contentType: ContentType.parse("image/$suffix1")
  ///   ),//图片1
  /// }
  /// upload(xxx,map:data).then((val){})
  ///
  upload(url, {map, cancelToken}) async {
    try {
      if (null == dioUpload) {
        dioUpload = new Dio();
        dioUpload.interceptors.add(CookieManager(CookieJar()));
      }
      Response response;
      FormData formData = FormData.from(map);
      if (map == null) {
        response = await dioUpload.post<String>(url, cancelToken: cancelToken);
      } else {
        response = await dioUpload.post<String>(url,
            data: formData, cancelToken: cancelToken);
      }
      LogUtil.v("文件上传 url = " + url);
      LogUtil.v("文件上传 statuscode = " + response.statusCode.toString());
      LogUtil.v("文件上传 body = " + formData.toString());
      LogUtil.v("文件上传 result = " + response.data.toString());
      LogUtil.v("文件上传 ${response.statusCode == 200 ? '成功' : '失败'}");
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      LogUtil.e("文件上传 url = " + url);
      LogUtil.e("文件上传 body = " + map.toString());
      LogUtil.e("文件上传 error = " + e.toString());
      return null;
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel('cancelled');
  }
}
