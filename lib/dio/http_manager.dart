import 'package:cxdemo/dio/request_result.dart';
import 'package:cxdemo/dio/response_interceptor.dart';
import 'package:cxdemo/dio/result_data.dart';
import 'package:cxdemo/dio/target_type.dart';
import 'package:dio/dio.dart';

import 'address.dart';
import 'code.dart';
import 'log_intercetors.dart';

class HttpManager {
  Dio dio;

  var baseUrl;

  var connectTimeOut = 15000;

  factory HttpManager() => getInstance();

  static HttpManager get instance => getInstance();

  static HttpManager _instance = HttpManager._internal();

  HttpManager._internal({String baseUrl}) {
    //初始化
    if (null == dio) {
      dio = new Dio(
          new BaseOptions(baseUrl: Address.BASE_URL, connectTimeout: 15000,responseType: ResponseType.plain));
      dio.interceptors.add(new LogInterceptors());
      dio.interceptors.add(new ResponseInterceptors());
    }
  }

  static HttpManager getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名
  HttpManager _baseUrl(String baseUrl) {
    if (dio != null) {
      dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般请求，默认域名
  HttpManager _normal() {
    if (dio != null) {
      if (dio.options.baseUrl != Address.BASE_URL) {
        dio.options.baseUrl = Address.BASE_URL;
      }
    }
    return this;
  }

  request(TargetType targetType) async {
    if (baseUrl == null) {
      print("请在main文件中配置baseUrl");
      return;
    }
    Response response;
    try {
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
            response =
                await dio.request(targetType.path, data: targetType.parameters);
            break;
        }
      } else {
        response = await dio.request(targetType.path);
      }
      return ValidateResult(ValidateType.success, data: response.data);
    } catch (exception) {
      try {
        DioError error = exception;
        Map dict = error.response.data;
        var message = dict["message"];
        return ValidateResult(ValidateType.failed,
            errorMsg: (message == null) ? "网络请求失败, 请重试" : message);
      } catch (error) {
        return ValidateResult(ValidateType.failed, errorMsg: "网络请求失败, 请重试");
      }
    }
  }

  ///通用的GET请求
  get(api, {params, withLoading = true}) async {
    if (withLoading) {
//      LoadingUtils.show();
    }
    if(params != null){
      dio.options.queryParameters = params;
    }

    Response response;
    try {
      response = await dio.get(api, queryParameters: params);
      if (withLoading) {
//        LoadingUtils.dismiss();
      }
    } on DioError catch (e) {
      if (withLoading) {
//        LoadingUtils.dismiss();
      }
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data['code']);
    }

    return response.data;
  }

  ///通用的POST请求
  post(api, {params, withLoading = true}) async {
    if (withLoading) {
//      LoadingUtils.show();
    }
    if(params != null){
      dio.options.queryParameters = params;
    }
    Response response;

    try {
      response = await dio.post(api, data: params);
      if (withLoading) {
//        LoadingUtils.dismiss();
      }
    } on DioError catch (e) {
      if (withLoading) {
//        LoadingUtils.dismiss();
      }
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data['code']);
    }

    return response.data;
  }

  ResultData resultError(DioError e) {
    Response errorResponse;
    if (e.response != null) {
      errorResponse = e.response;
    } else {
      errorResponse = new Response(statusCode: 666);
    }
    if (e.type == DioErrorType.CONNECT_TIMEOUT ||
        e.type == DioErrorType.RECEIVE_TIMEOUT) {
      errorResponse.statusCode = Code.NETWORK_TIMEOUT;
    }
    return new ResultData(
        errorResponse.statusMessage, false, errorResponse.statusCode);
  }
}
