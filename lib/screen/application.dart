import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:hive/hive.dart';
import 'package:task_management_app/constants/props.dart';
import 'package:task_management_app/global_provider/app_provider.dart';
import 'package:task_management_app/modules/route_observer.dart';
import 'package:task_management_app/repository/local/store_data/store.box.dart';
import 'package:task_management_app/repository/local/store_data/system.dart';
import 'package:task_management_app/style/theme.dart';
import 'package:task_management_app/utils/animations/transitions_helper.dart';
import 'package:task_management_app/widget/dialog/dialog_no_internet_connection.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with AfterLayoutMixin {
  StreamSubscription? subscription;
  late StreamSubscription<BoxEvent> subscriptionBox;

  @override
  void initState() {
    // OneSignal.shared.setNotificationOpenedHandler(checkNotification);
    // OneSignal.shared.setNotificationReceivedHandler(checkNotificationReceive);
    subscriptionBox = Hive.box<StoreSystemData>(systemBox).watch().listen((BoxEvent event) {
      // print("========== ON Box Delete ==========");
      // if (event.value?.companyID == null) context.read<AppProvider>().logout();
      // print(event.value);
      // print("========== ON Box Delete ==========");
    });
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print(result);
      try {
        if (result == ConnectivityResult.none) {
          BotToast.showAnimationWidget(
            animationDuration: Duration(milliseconds: 250),
            backgroundColor: Colors.black.withOpacity(0.5),
            wrapToastAnimation: (controller, cancelFunc, widget) => TransitionsHelper.fadeTransition(widget, controller),
            onlyOne: true,
            animationReverseDuration: Duration(milliseconds: 250),
            allowClick: false,
            crossPage: true,
            clickClose: false,
            toastBuilder: (void Function() cancelFunc) => DialogInternetConnection(),
          );
        } else {
          BotToast.removeAll();
        }
      } catch (e, s) {
        print(s);
        BotToast.removeAll();
      }
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        return;
      },
      child: MaterialApp(
        initialRoute: Modular.initialRoute,
        // initialRoute: "/login",
        // navigatorKey: navKey,
        debugShowCheckedModeBanner: false,
        title: "Task Management App",
        theme: Style.theme(context),
        builder: BotToastInit(),
        supportedLocales: EasyLocalization
            .of(context)!
            .supportedLocales,
        navigatorObservers: [
          MyRouteObserver(),
          BotToastNavigatorObserver(),
          BotToastNavigatorObserver(),
        ],
        locale: EasyLocalization
            .of(context)!
            .locale,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          EasyLocalization
              .of(context)!
              .delegate,
        ],
      ).modular(),
    );
  }
}
//   void checkNotification(OSNotificationOpenedResult openedResult) {
//     print(openedResult.notification.payload);
//   }
//
//   void checkNotificationReceive(OSNotification notification) {}
// }
