import 'package:dio/dio.dart';

class APIResponse<T> {
  // extends Response<T>
  APIStatus? status;
  T? data;
  String? _message;
  int? statusCode;
  bool isComplete = false;
  Response? response;

  APIResponse.loading(String? message) {
    status = APIStatus.loading;
    _message = message;
  }

  APIResponse.completed(
      this.data, {
        required Response response,
        String? message,
      }) {
    status = APIStatus.completed;
    isComplete = true;
    statusCode = 200;
    _message = message;
    this.response = response;
  }

  APIResponse.error(
      String message, {
        this.data,
        this.statusCode = 500,
        Response? response,
      }) {
    status = APIStatus.error;
    _message = message;
    isComplete = false;
    this.response = response;
  }

  APIResponse({
    this.status,
    this.data,
    this.statusCode = 200,
    this.isComplete = false,
  });

  bool get hasData => data != null;

  String? get message {
    try {
      String? msg = (response?.data ?? {})["message"];
      return _message ?? msg;
    } catch (e) {
      return _message;
    }
  }

  set message(String? value) {
    _message = value;
  }

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum APIStatus { loading, completed, error }
