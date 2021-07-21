import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Format {
  Format();

  static String? formatTimeOfDay24([TimeOfDay? timeOfDay]) {
    TimeOfDay tod = timeOfDay ?? TimeOfDay.now();
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat("HH:mm");
    return format.format(dt);
  }

  static String? checkStringEmptyReturnNull(String str) {
    try {
      var n = str.trim();
      if (n.isEmpty) {
        throw "String is Empty ";
      } else {
        return n;
      }
    } catch (e) {
      return null;
    }
  }

  static bool checkStringNotNull(String str) {
    try {
      return str.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
