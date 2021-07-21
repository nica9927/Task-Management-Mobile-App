import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:package_info/package_info.dart';
import 'package:task_management_app/constants/api_const.dart';
import 'package:task_management_app/repository/local/base_local.dart';
import 'package:task_management_app/repository/local/store_data/store.box.dart';
import 'package:task_management_app/repository/local/store_data/system.dart';
import 'package:task_management_app/repository/network/base/api_provider.dart';
import 'package:task_management_app/repository/network/base/response.dart';
import 'package:task_management_app/utils/helper.dart';
import 'package:task_management_app/utils/utils_function.dart';

import 'api_exception.dart';
import 'app_Interceptors_log.dart';

class AppInterceptors extends Interceptor {
  final _local = BaseLocalRepository();
  final NetworkProvider network;
  final Dio dio;

  AppInterceptors(this.network, this.dio);

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      String url = options.uri.toString().replaceAll(options.baseUrl, '');
      options.baseUrl = network.pathMapping(url);
      var data = options.data;
      var user = Hive.box<StoreSystemData>(systemBox).getAt(0);

      var token = user?.apiToken;
      var companyID = user?.companyID ?? 4;
      if (companyID == null && !(options.uri.toString().contains("login"))) {
        return handler.reject(DioError(requestOptions: options, type: DioErrorType.cancel));
      }
      var r = await PackageInfo.fromPlatform();
      var deviceID = await this._local.getUniqueID();
      options.headers.addAll(
        {
          "appName": "${r.appName}",
          "packageName": "${r.packageName}",
          "version": "${r.version}",
          "buildNumber": "${r.buildNumber}",
          "deviceID": "${deviceID ?? ''}",
          "companyID": "${companyID ?? ''}",
        },
      );
      if (token != null)
        options.headers.update(
          "Authorization",
              (value) => "Bearer $token",
          ifAbsent: () => "Bearer $token",
        );
      if (options.method == "GET") {
        options.queryParameters = (options.queryParameters);
      }
      if (data is FormData) {
        // if (data == null) data = FormData.fromMap({});
        data.fields.addAll({});
      } else {
        if (data == null) data = <String, dynamic>{};
      }
      options.data = data;
    } catch (e, s) {
      print(s);
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    // try {
    //   if ((err.response!.statusCode == 401 || err.response!.statusCode == 403) && err.requestOptions.headers['Authorization'] != null) {
    //     this.dio.lock();
    //     var res = await refreshToken();
    //     this.dio.unlock();
    //     if (res.isComplete) {
    //       var tokenData = res.data!;
    //       var user = Hive.box<StoreSystemData>(systemBox).getAt(0)!;
    //       user.apiToken = tokenData.accessToken;
    //       user.refreshToken = tokenData.refreshToken;
    //       await user.save();
    //       var resRetry = await retry(err.requestOptions, token: tokenData.accessToken!);
    //       if (resRetry.statusCode != 200) return handler.next(err);
    //       return handler.resolve(resRetry);
    //     } else {
    //       Helper.showMessage(
    //         title: "Logout",
    //         color: Colors.orange,
    //         message: "Session expired, Please sign in again",
    //       );
    //       await clearCompanyLocal();
    //     }
    //   }
    //   APIException exception = APIException(
    //     requestOptions: err.requestOptions,
    //     error: err.error,
    //     response: err.response,
    //     type: err.type,
    //   );
    //   return handler.next(exception);
    // } catch (e, s) {
    //   return handler.next(err);
    // }
  }

  // Future<APIResponse<UserKeyCloak>> refreshToken() async {
  //   try {
  //     var user = Hive.box<StoreSystemData>(systemBox).getAt(0);
  //     var token = user?.refreshToken;
  //     var companyID = user?.companyID ?? 4;
  //     var r = await PackageInfo.fromPlatform();
  //     var deviceID = await this._local.getUniqueID();
  //     var res = await (Dio()
  //       ..interceptors.add(AppInterceptorsLogger(
  //         requestHeader: true,
  //         requestBody: true,
  //         responseBody: true,
  //         responseHeader: false,
  //         compact: true,
  //       )))
  //         .post(
  //       APIConstance().urlRefreshToken,
  //       data: {
  //         "refreshToken": token,
  //       },
  //       options: Options(
  //         headers: {
  //           "appName": "${r.appName}",
  //           "packageName": "${r.packageName}",
  //           "version": "${r.version}",
  //           "buildNumber": "${r.buildNumber}",
  //           "deviceID": "${deviceID ?? ''}",
  //           "companyID": "${companyID ?? ''}",
  //         },
  //       ),
  //     );
  //     return APIResponse.completed(
  //       UserKeyCloak.fromJson(res.data),
  //       response: res,
  //     );
  //   } catch (e) {
  //     return APIResponse.error("$e");
  //   }
  // }

  Future<Response<dynamic>> retry(RequestOptions requestOptions, {required String token}) {
    requestOptions.headers.update(
      "Authorization",
          (value) => "Bearer $token",
      ifAbsent: () => "Bearer $token",
    );
    return this.dio.fetch(requestOptions);
  }
}
