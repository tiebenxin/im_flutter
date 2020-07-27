import 'package:cxdemo/dio/target_type.dart';

import 'http_manager.dart';

class Api {
  static apiLogin() {
    return TargetType().config(
        path: "",
        headers: {},
        method: ERequestMethod.GET,
        parameters: {},
        encoding: ParameterEncoding.URLEncoding);
  }
}

final HttpManager httpManager = HttpManager.instance;
