import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:quickblox_sdk/auth/module.dart';
import 'package:quickblox_sdk/models/qb_session.dart';
import 'package:quickblox_sdk/models/qb_user.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';
import 'package:task_management_app/global_provider/app_provider.dart';
import 'package:task_management_app/modules/router.dart';
import 'package:provider/provider.dart';


class HomeProvider extends ChangeNotifier {
  String? _username;
  String? _password;
  QBUser? qbUser;
  QBSession? qbSession;
  bool connected = false;

  Future<void> login(BuildContext context) async {
    try {
      QBLoginResult result = await QB.auth.login(username!, password!);
      qbUser = result.qbUser;
      context.read<AppProvider>().qbUser = qbUser;
      qbSession = result.qbSession;
      if(qbUser != null){
        connected = await QB.chat.isConnected() ?? false;
        if(connected == false){
          await QB.chat.connect(qbUser!.id!, password!);
          await QB.webrtc.init();
        }
        Modular.to.pushNamed(AppRouter.fromModule().room);
      }
    }catch (e) {
      print(e);
    }
  }

  String? get username => _username;

  set username(String? value) {
    _username = value;
    notifyListeners();
  }

  String? get password => _password;

  set password(String? value) {
    _password = value;
    notifyListeners();
  }
}
