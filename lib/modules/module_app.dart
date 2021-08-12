import 'package:task_management_app/screen/main/chat/chat_provider.dart';
import 'package:task_management_app/screen/main/chat/chat_screen.dart';
import 'package:task_management_app/screen/main/chat_test/agora_chat_provider.dart';
import 'package:task_management_app/screen/main/chat_test/agora_chat_screen.dart';
import 'package:task_management_app/screen/main/home/home_provider.dart';
import 'package:task_management_app/screen/main/home/home_screen.dart';
import 'package:task_management_app/screen/main/room/room_provider.dart';
import 'package:task_management_app/screen/main/room/room_screen.dart';
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
        ChildRoute(
          appRouter.room,
          transition: TransitionType.custom,
          customTransition: transition.fadeThroughTransition,
          child: (context, args) => ChangeNotifierProvider<RoomProvider>(
            create: (context) => RoomProvider(),
            child: RoomScreen(),
          ),
        ),
        ChildRoute(
          appRouter.chat,
          transition: TransitionType.custom,
          customTransition: transition.fadeThroughTransition,
          child: (context, args) => ChangeNotifierProvider<ChatProvider>(
            create: (context) => ChatProvider(),
            child: ChatScreen(),
          ),
        ),
        ChildRoute(
          appRouter.agoraChat,
          transition: TransitionType.custom,
          customTransition: transition.fadeThroughTransition,
          child: (context, args) => ChangeNotifierProvider<AgoraChatProvider>(
            create: (context) => AgoraChatProvider(),
            child: AgoraChatScreen(),
          ),
        ),
      ];
}
