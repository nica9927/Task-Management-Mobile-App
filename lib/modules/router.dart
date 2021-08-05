class AppRouter {
  AppRouter({this.currentModule = ""});

  static AppRouter fromModule({String moduleName = ""}) => AppRouter(currentModule: moduleName);

  static AppRouter fromHomeModule() => AppRouter(currentModule: "/home");

  static AppRouter toSaleModule() => AppRouter(currentModule: "/home/sales");
  String currentModule = "";

  String get login => currentModule + "/login";

  String get home => "/home";

  String get room => "/room";

  String get chat => "/chat";





  static AppRouter check() => AppRouter();

  bool getWhiteStatusBar(String screenName) {
    bool check = false;
    List<String> whiteStatus = [
      home,
    ];
    for (var i in whiteStatus) {
      if (i.contains(screenName)) {
        check = true;
      }
      if (check) break;
    }
    return check;
  }
}
