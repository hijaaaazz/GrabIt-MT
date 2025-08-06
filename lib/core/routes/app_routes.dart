import 'package:flutter/material.dart';
import 'package:grabit/features/main/view/main_page.dart';

class Routes {
  static const splash = '/splash';
  static const main = '/main';
}

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.main:
        return MaterialPageRoute(builder: (_) => const MainPage());
      default:
        return MaterialPageRoute(builder: (_) => const MainPage());
    }
  }
}
