import 'dart:io';

import 'package:camera/camera.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'repository/local/store_data/store.box.dart';
import 'repository/local/store_data/system.dart';

class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

List<CameraDescription> cameras = [];

class Environment {
  static setup() async {
    WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp();
    Provider.debugCheckInvalidValueType = null;
    HttpOverrides.global = _MyHttpOverrides();
    cameras = await availableCameras();
    await initHiveBox();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
    // OneSignal.shared.init("5d592ce8-b90f-450b-a41b-84d209c0fed7", iOSSettings: {
    //   OSiOSSettings.autoPrompt: true,
    //   OSiOSSettings.inAppLaunchUrl: true,
    // });
    // OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
    //
    // await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);
    return;
  }
}

Future<void> initHiveBox({bool justOpenBox = false}) async {
  try {
    if (!justOpenBox) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      Hive..init(appDocDir.path);
    }

    /// registerAdapter
    Hive.registerAdapter<StoreSystemData>(StoreSystemDataAdapter());

    /// openBox
    Box<StoreSystemData>? _systemBox;
    if (!Hive.isBoxOpen(systemBox)) _systemBox = await Hive.openBox<StoreSystemData>(systemBox);

    /// if Box is isEmpty
    if (_systemBox != null) if (_systemBox.isEmpty) await _systemBox.add(StoreSystemData());
  } catch (e) {}
}
