import 'package:task_management_app/screen/application.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'environment.dart';
import 'global_provider/app_provider.dart';
import 'modules/module_app.dart';

Future<void> main() async {
  await Environment.setup();
  runApp(EasyLocalization(
    supportedLocales: [
      Locale('en', 'US'),
      Locale('th', 'TH'),
    ],
    startLocale: Locale('en', 'US'),
    fallbackLocale: Locale('en', 'US'),
    path: 'assets/translations',
    child: MultiProvider(
      child: ModularApp(
        module: AppModule(),
        child: Application(),
      ),
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<AppProvider>(create: (BuildContext context) => AppProvider()),
      ],
    ),
  ));
}
