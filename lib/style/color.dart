import 'package:flutter/material.dart';

class AppColor {
  static const MaterialColor primaryColor = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(_primaryValue),
      100: Color(0xff17bdc8),
      200: Color(0xff26b4bd),
      300: Color(0xff35acb3),
      400: Color(0xff44a3a9),
      500: Color(0xff539a9e),
      600: Color(0xff629194),
      700: Color(0xff71888a),
    },
  );
  static const int _primaryValue = 0xFF08C6D2;
  static const Color backgroundTabColor = Color(0xff10a2b4);
}

