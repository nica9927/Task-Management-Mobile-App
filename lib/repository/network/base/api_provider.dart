import 'package:task_management_app/constants/api_const.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'app_Interceptors.dart';

class NetworkProvider extends APIConstance {
  NetworkProvider();

  Dio createDio(String baseUrl) {
    return Dio(BaseOptions(
      connectTimeout: 1000 * 20,
      receiveTimeout: 1000 * 120,
      baseUrl: baseUrl,
    ));
  }

  Dio addInterceptors(Dio dio, {List<String>? exceptionURL}) {
    return dio
      // ..transformer = TransformData()
      ..interceptors.add(AppInterceptors(this,dio))
      ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: true,
      ));
  }
}
