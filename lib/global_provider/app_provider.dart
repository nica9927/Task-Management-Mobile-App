
import 'package:task_management_app/modules/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


class AppProvider extends ChangeNotifier {

  Future<void> init() async {
    try {
      Modular.to.navigate(AppRouter.fromHomeModule().home, replaceAll: true);
    } catch (e,s) {
      print("init : $s");
    }
  }



}
