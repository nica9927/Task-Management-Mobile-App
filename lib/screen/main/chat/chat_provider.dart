import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:quickblox_sdk/chat/constants.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';
import 'package:quickblox_sdk/models/qb_filter.dart';
import 'package:quickblox_sdk/models/qb_message.dart';
import 'package:quickblox_sdk/models/qb_sort.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';

class ChatProvider extends ChangeNotifier {
  int? userId;
  int? opponentId;
  String? opponentName;
  int dialogType = QBChatDialogTypes.CHAT;
  List<int> occupantsIds = [];
  QBDialog? _dialog;
  String? body;
  List<QBMessage?> _messages = [];


  ChatProvider() {
    var data = Modular.args?.data ?? {};
    userId = data["userId"];
    opponentId = data["opponentId"];
    opponentName = data["opponentName"];
    occupantsIds = [userId!, opponentId!];
  }

  Future<void> createDialog() async {
    try {
      var r = await QB.chat.createDialog(occupantsIds, opponentName ?? "",
          dialogType: dialogType);
      dialog = r;
      print("dialog id : ${dialog!.id}");
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendMsg() async {
    var dialogId = dialog!.id!;
    DateTime date = DateTime.now();
    try {
      await QB.chat.sendMessage(dialogId, body: body, saveToHistory: true);
    } catch (e) {
      print(e);
    }
  }

  Future<void> subscribe(StreamSubscription? sub) async {
    String event = QBChatEvents.RECEIVED_NEW_MESSAGE;
    try {
      sub = await QB.chat.subscribeChatEvent(event, (data) {
        Map<dynamic, dynamic> map = Map<dynamic, dynamic>.from(data);
        Map<dynamic, dynamic> payload =
            Map<dynamic, dynamic>.from(map["payload"]);
        String? messageId = payload["id"];
        print(messageId);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> receiveMsg() async {
    String dialogId = dialog!.id!;

    QBSort sort = QBSort();
    sort.field = QBChatDialogSorts.LAST_MESSAGE_DATE_SENT;
    sort.ascending = true;

    QBFilter filter = QBFilter();
    filter.field = QBChatDialogFilterFields.LAST_MESSAGE_DATE_SENT;
    filter.operator = QBChatDialogFilterOperators.ALL;

    int limit = 100;
    int skip = 50;
    bool markAsRead = true;

    try {
      messages = await QB.chat.getDialogMessages(
        dialogId,
        sort: sort,
        filter: filter,
        limit: limit,
        // skip: skip,
        markAsRead: markAsRead,
      );
    } catch (e) {
      print(e);
    }
  }

  List<QBMessage?> get messages => _messages;

  set messages(List<QBMessage?> value) {
    _messages = value;
    notifyListeners();
  }

  QBDialog? get dialog => _dialog;

  set dialog(QBDialog? value) {
    _dialog = value;
    notifyListeners();
  }
}
