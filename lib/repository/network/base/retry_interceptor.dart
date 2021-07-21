import 'dart:async';

import 'package:dio/dio.dart';
import 'package:task_management_app/repository/network/base/api_provider.dart';


import 'app_Interceptors_log.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final NetworkProvider networkProvider;

  RetryOnConnectionChangeInterceptor(this.networkProvider);

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    print(err);
    if (err.response?.statusCode == 401) {
      var r = await refreshToken();
      if (r) {
        var res = await _retry(err.requestOptions);
        if (res?.statusCode != 200) return handler.reject(err);
        return handler.resolve(res!);
      }
    }
    return handler.next(err);
  }

  Future<bool> refreshToken() async {
    try {
      var dio = networkProvider.createDio("");
      await dio.post(
        networkProvider.apiRefreshTokenPath,
        data: {"token": "dfjuikvdfkjvdfgjkb nfgbju frvb frgjkvbnfgvhjv frg"},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Response<dynamic>?> _retry(RequestOptions requestOptions) async {
    try {
      final options = new Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
      );
      var dio = networkProvider.createDio(requestOptions.baseUrl);
      dio.interceptors.add(AppInterceptorsLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: true,
      ));
      print(requestOptions.uri.path.toString());
      print(requestOptions.baseUrl + requestOptions.uri.path);
      return await dio.request(
        requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options,
      );
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      return Response(
        requestOptions: requestOptions,
        statusCode: 500,
      );
    }
  }
}
