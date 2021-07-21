import 'package:dio/dio.dart';

class APIException extends DioError {
  // int statusCode = 200;
  // String message;
  // dynamic data;

  // APIException({DioError dioError,this.message}) {
  //   var data = this.response.data ?? {};
  //   message = data["error"] ?? data["err"] ?? this.message;
  // }
  // APIException.form({DioError dioError}) {
  //   requestOptions = dioError.requestOptions;
  //   response = dioError.response;
  //   type = dioError.type;
  //   error = dioError.error;
  //   // var data = this.response.data ?? {};
  //   // message = data["error"] ?? data["err"] ?? this.message;
  // }

  String get messageCustom {
    try {
      if (this.response == null) throw ("No Response");
      var data = this.response!.data ?? {};
      var _message = data["error"] ?? data["err"] ?? data["msg"] ?? data["message"] ?? data["MSG"] ?? data["ERRORMSG"] ?? this.message;
      return _message;
    } catch (e) {
      return "$e";
    }
  }

  @override
  String toString() {
    return '$messageCustom';
  }

  APIException({
    required RequestOptions requestOptions,
    Response? response,
    DioErrorType type = DioErrorType.other,
    error
}) : super (
    requestOptions: requestOptions,
    type: type,
    response: response,
    error: error
  );
}
