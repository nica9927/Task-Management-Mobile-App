import 'package:flutter/material.dart';

class HelperPlaceHolder {
  static Widget imagePlaceHolder() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.person_outline_rounded),
    );
  }
}
