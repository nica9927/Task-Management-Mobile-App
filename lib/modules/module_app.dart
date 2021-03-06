import 'package:task_management_app/screen/main/home/home_provider.dart';
import 'package:task_management_app/screen/main/home/home_screen.dart';
import 'package:task_management_app/screen/start/start_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import 'page_transition.dart';
import 'router.dart';

class AppModule extends Module {
  final AppRouter appRouter = AppRouter();
  final MyPageTransition transition = MyPageTransition();

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          transition: TransitionType.custom,
          customTransition: transition.fadeThroughTransition,
          child: (context, args) => StartScreen(),
        ),
        ChildRoute(
          appRouter.home,
          transition: TransitionType.custom,
          customTransition: transition.fadeThroughTransition,
          child: (context, args) => ChangeNotifierProvider<HomeProvider>(
            create: (context) => HomeProvider(),
            child: HomeScreen(),
          ),
        ),
      ];
}
