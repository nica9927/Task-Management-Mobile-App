import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/utils/custom_box_shadow.dart';

final navKey = GlobalKey<NavigatorState>();

var boxElevation = [
  BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 6.0,
    spreadRadius: 0.01,
    offset: Offset(4.0, 4.0),
  ),
];

var boxShadow = [
  CustomBoxShadow(
    color: Colors.grey.withOpacity(0.3),
    offset: Offset(1.0, 5.0),
    blurRadius: 10.0,
    blurStyle: BlurStyle.outer,
  )
];

var textShadow = [
  Shadow(
    offset: Offset(10.0, 10.0),
    blurRadius: 3.0,
    color: Color.fromARGB(255, 0, 0, 0),
  ),
  Shadow(
    offset: Offset(10.0, 10.0),
    blurRadius: 8.0,
    color: Color.fromARGB(125, 0, 0, 255),
  ),
];
const spinkit = SpinKitRotatingCircle(
  color: Colors.orange,
  size: 20,
);
final formatPrice = NumberFormat("#,##0.00");
final formatNumber = NumberFormat("#,###");
final formatTime2Digit = NumberFormat("00");
final formatId = NumberFormat("#-####-#####-##-#");

final formatterDataFullWithoutTime = DateFormat("EEEE, dd MMMM yyyy");
final formatterDataTimeFull = DateFormat("EEEE, dd MMMM yyyy HH:mm:ss");
final formatterData = DateFormat("dd/MM/yyyy");
final formatterDataTime = DateFormat("dd/MM/yyyy HH:mm:ss");
final formatterDateDash = DateFormat("dd-MM-yyyy");
final formatterTime = DateFormat("HH:mm:ss");
final formatterDateServer = DateFormat("yyyy-MM-dd");
final formatterDateTimeServer = DateFormat("yyyy-MM-dd HH:mm:ss");
final formatterDataMMM = DateFormat("MMMM dd, yyyy");
final formatterDateJM = DateFormat.jm();

final dateTimeNow = DateTime.now();
final dateFirstDay =
DateTime(dateTimeNow.year - 10, dateTimeNow.month, dateTimeNow.day);
final dateLastDay =
DateTime(dateTimeNow.year + 10, dateTimeNow.month, dateTimeNow.day);

