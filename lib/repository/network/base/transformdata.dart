import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class TransformData extends DefaultTransformer {
  TransformData() : super(jsonDecodeCallback: _parseJson);

  @override
  Future transformResponse(RequestOptions options, ResponseBody response) async {
    return await super.transformResponse(options, response);
  }
}

// Must be top-level function
_parseAndDecode(String response) {
  return jsonDecode(response);
}

_parseJson(String text) {
  return compute(_parseAndDecode, text);
}
