import 'dart:io';

import 'package:task_management_app/repository/local/base_local.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'api_provider.dart';

class BaseRepository extends NetworkProvider {
  late Dio dio;
  BaseLocalRepository local = BaseLocalRepository();

  BaseRepository({Dio? dio}) {
    this.dio = dio ??
        addInterceptors(
          createDio(pathMapping("")),
        );
    (this.dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    };
  }
}
