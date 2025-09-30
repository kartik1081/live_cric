import 'package:flutter/material.dart';
import 'package:live_cric/pages/splash/controller.dart';
import 'package:live_cric/pages/splash/view.dart';
import 'package:provider/provider.dart';

class Routes {
  static const String splashRt = "/";

  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case splashRt:
        return MaterialPageRoute(
          settings: RouteSettings(name: splashRt),
          builder: (context) => ChangeNotifierProvider<SplashController>(
            create: (context) => SplashController(context),
            lazy: false,
            child: SplashView(),
          ),
        );
      default:
        return MaterialPageRoute(
          settings: RouteSettings(name: splashRt),
          builder: (context) => ChangeNotifierProvider<SplashController>(
            create: (context) => SplashController(context),
            lazy: false,
            child: SplashView(),
          ),
        );
    }
  }
}
