import 'package:flutter_modular/flutter_modular.dart';

import 'page_transition.dart';
import 'router.dart';

class HomeModule extends Module {
  final AppRouter appRouter = AppRouter();

  final MyPageTransition transition = MyPageTransition();

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [];
}
