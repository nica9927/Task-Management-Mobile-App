import 'package:quickblox_sdk/models/qb_user.dart';
import 'package:task_management_app/modules/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class AppProvider extends ChangeNotifier {
  String appId = "93289";
  String authKey = "eD3VhYaBP9f7uJP";
  String authSecret = "HR9yy2HZn2pc7xA";
  String accountKey = "XzFDgeK1krYdFM2numV9";
  QBUser? _qbUser;
  bool autoReconnect = true;
  int messageTimeout = 3;

  // String apiEndpoint = "api.endpoint.com";
  // String chatEndpoint = "chat.enpoint.com";

  Future<void> setupQuickBlox() async {
    try {
      await QB.settings.init(
        appId,
        authKey,
        authSecret,
        accountKey,
        // apiEndpoint: apiEndpoint,
        // chatEndpoint: chatEndpoint,
      );
    }catch(e){
      print("$e");
    }
  }

  Future<void> init() async {
    try {
      await setupQuickBlox();

      await initStreamManagement();
      Modular.to.navigate(AppRouter
          .fromHomeModule()
          .home, replaceAll: true);
    } catch (e, s) {
      print("init : $s");
    }
  }



  Future<void> initStreamManagement() async {
    try {
      await QB.settings.initStreamManagement(messageTimeout, autoReconnect: autoReconnect);
    }catch (e) {
      // Some error occurred, look at the exception message for more details
    }
  }

  QBUser? get qbUser => _qbUser;

  set qbUser(QBUser? value) {
    _qbUser = value;
    notifyListeners();
  }
}
