

import 'package:flutter/material.dart';
import 'package:quickblox_sdk/models/qb_user.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class RoomProvider extends ChangeNotifier{

  bool _connected = false;
  List<QBUser?> _listUser =[];

  Future<void> isConnected() async {
    try {
      connected = await QB.chat.isConnected() ?? false;
    }  catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      await QB.auth.logout();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUsers() async {
   var res = await QB.users.getUsers();
    listUser = res;
    // listUser.removeAt(0);
  }


  List<QBUser?> get listUser => _listUser;

  set listUser(List<QBUser?> value) {
    _listUser = value;
    notifyListeners();
  }

  bool get connected => _connected;

  set connected(bool value) {
    _connected = value;
    notifyListeners();
  }
}