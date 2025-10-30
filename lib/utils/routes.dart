import 'package:flutter/material.dart';
import 'package:live_cric/pages/home/controller.dart';
import 'package:live_cric/pages/home/view.dart';
import 'package:live_cric/pages/scorecard/controller.dart';
import 'package:live_cric/pages/scorecard/view.dart';
import 'package:live_cric/pages/splash/controller.dart';
import 'package:live_cric/pages/splash/view.dart';
import 'package:live_cric/utils/const.dart';
import 'package:provider/provider.dart';

class Routes {
  static const String splashRt = "/";
  static const String homeRt = "/home";
  static const String scorecardRt = "/scorecard";
  static const String playerProfileRt = "/player_profile";

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
      case homeRt:
        return MaterialPageRoute(
          settings: RouteSettings(name: homeRt),
          builder: (context) => ChangeNotifierProvider<HomeController>(
            create: (context) => HomeController(context),
            child: HomeView(),
          ),
        );
      case scorecardRt:
        final args = setting.arguments as dynamic;
        return MaterialPageRoute(
          settings: RouteSettings(name: homeRt),
          builder: (context) => ChangeNotifierProvider<ScorecardController>(
            create: (context) =>
                ScorecardController(context, matchId: args[matchIdKey]),
            child: ScorecardView(),
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
