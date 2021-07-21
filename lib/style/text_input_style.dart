import 'package:flutter/material.dart';

class TextInputStyle {
  static InputDecoration textFieldStyle({String labelTextStr = "", String? hintTextStr}) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(12),
      labelText: labelTextStr,
      hintText: hintTextStr,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
    );
  }

  static InputDecoration textFieldStyleUnderLine({String? labelTextStr, String? hintTextStr, IconData? icon}) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(12),
      labelText: labelTextStr,
      hintText: hintTextStr,
      labelStyle: TextStyle(color: Colors.black54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
      prefixIcon: icon != null ? Icon(icon, color: Colors.orange) : null,
      fillColor: Colors.grey.withOpacity(0.1),
      hintStyle: TextStyle(
        color: Colors.black54.withOpacity(0.8),
      ),
      filled: true,
    );
  }
}
