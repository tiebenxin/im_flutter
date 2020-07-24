import 'package:cxdemo/dio/request_result.dart';
import 'package:cxdemo/dio/target_type.dart';
import 'package:dio/dio.dart';

import 'log_intercetors.dart';

class HttpManager {
  Dio dio;

  var baseUrl;

  var connectTimeOut = 15000;

  factory HttpManager() => _getInstance();

  static HttpManager get instance => _getInstance();

  static HttpManager _instance;

  HttpManager._internal() {
    //初始化
  }

  static HttpManager _getInstance() {
    if (_instance == null) {
      _instance = HttpManager._internal();
      _instance.dio = new Dio();
      _instance.dio.interceptors.add(LogInterceptors());
    }
    return _instance;
  }

  request(TargetType targetType) async {
    if (baseUrl == null) {
      print("请在main文件中配置baseUrl");
      return;
    }
    Response response;
    try{
      final options =
      BaseOptions(baseUrl: baseUrl, connectTimeout: connectTimeOut);
      if (targetType.headers != null) {
        options.headers = targetType.headers;
      }
      switch (targetType.method) {
        case ERequestMethod.GET:
          options.method = "GET";
          break;
        case ERequestMethod.POST:
          options.method = "POST";
          break;
        case ERequestMethod.PATCH:
          options.method = "PATCH";
          break;
        case ERequestMethod.UPLOAD:
          options.method = "UPLOAD";
          break;
        case ERequestMethod.DELETE:
          options.method = "DELETE";
          break;
        case ERequestMethod.DOWNLOAD:
          options.method = "DOWNLOAD";
          break;
      }
      if (targetType.parameters != null) {
        switch (targetType.encoding) {
          case ParameterEncoding.URLEncoding:
            response = await dio.request(targetType.path,
                queryParameters: targetType.parameters);
            break;
          case ParameterEncoding.BodyEncoding:
            response = await dio.request(targetType.path,
                data: targetType.parameters);
            break;
        }
      } else {
        response = await dio.request(targetType.path);
      }
      return ValidateResult(ValidateType.success, data: response.data);
    }catch(exception){
      try{
        DioError error = exception;
        Map dict = error.response.data;
        var message =  dict["message"] ;
        return ValidateResult(ValidateType.failed, errorMsg: (message == null) ? "网络请求失败, 请重试" : message);
      }catch (error) {
        return ValidateResult(ValidateType.failed, errorMsg: "网络请求失败, 请重试");
      }
    }

  }
}
