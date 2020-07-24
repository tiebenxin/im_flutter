enum ERequestMethod {
  POST,
  GET,
  PATCH,
  DELETE,
  UPLOAD,
  DOWNLOAD,
}

enum ParameterEncoding {
  /// 参数放在URL中
  URLEncoding,

  /// 参数放在body中
  BodyEncoding
}

class TargetType {
  ///接口地址
  String path;

  ///请求方法
  ERequestMethod method;

  ///参数
  Object parameters;

  /// 参数放置位置(仅有参数时 需要传)
  ParameterEncoding encoding;

  ///请求头
  Map headers;

  config(
      {String path,
      ERequestMethod method = ERequestMethod.GET,
      Object parameters,
      ParameterEncoding encoding,
      Map headers}) {
    this.path = path;
    this.method = method;
    if (parameters != null) {
      this.parameters = parameters;
    }
    if (headers != null) {
      this.headers = headers;
    }
    return this;
  }
}
