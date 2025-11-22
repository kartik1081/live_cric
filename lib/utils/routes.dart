import 'package:flutter/material.dart';
import 'package:live_cric/pages/home/controller.dart';
import 'package:live_cric/pages/home/view.dart';
import 'package:live_cric/pages/onboard/controller.dart';
import 'package:live_cric/pages/onboard/view.dart';
import 'package:live_cric/pages/privacy/controller.dart';
import 'package:live_cric/pages/privacy/view.dart';
import 'package:live_cric/pages/scorecard/controller.dart';
import 'package:live_cric/pages/scorecard/view.dart';
import 'package:live_cric/pages/select_country/controller.dart';
import 'package:live_cric/pages/select_country/view.dart';
import 'package:live_cric/pages/splash/controller.dart';
import 'package:live_cric/pages/splash/view.dart';
import 'package:live_cric/pages/video_stream/controller.dart';
import 'package:live_cric/pages/video_stream/view.dart';
import 'package:live_cric/pages/web_stream/controller.dart';
import 'package:live_cric/pages/web_stream/view.dart';
import 'package:live_cric/utils/const.dart';
import 'package:provider/provider.dart';

class Routes {
  static const String splashRt = "/";
  static const String onboardRt = "/onboard";
  static const String privacyConsentRt = "/pricacy_consent";
  static const String selectCountryRt = "/select_country";
  static const String homeRt = "/home";
  static const String scorecardRt = "/scorecard";
  static const String playerProfileRt = "/player_profile";
  static const String videoStreamRt = "/video_stream";
  static const String webStreamRt = "/web_stream";

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
      case onboardRt:
        return MaterialPageRoute(
          settings: RouteSettings(name: onboardRt),
          builder: (context) => ChangeNotifierProvider<OnboardController>(
            create: (context) => OnboardController(),
            child: OnboardView(),
          ),
        );
      case privacyConsentRt:
        return MaterialPageRoute(
          settings: RouteSettings(name: privacyConsentRt),
          builder: (context) => ChangeNotifierProvider<PrivacyController>(
            create: (context) => PrivacyController(context),
            child: PrivacyView(),
          ),
        );
      case selectCountryRt:
        return MaterialPageRoute(
          settings: RouteSettings(name: selectCountryRt),
          builder: (context) => ChangeNotifierProvider<SelectCountryController>(
            create: (context) => SelectCountryController(),
            child: SelectCountryView(),
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
                ScorecardController(context, match: args[matchKey]),
            child: ScorecardView(),
          ),
        );
      case videoStreamRt:
        final args = setting.arguments as dynamic;
        return MaterialPageRoute(
          settings: RouteSettings(name: homeRt),
          builder: (context) => ChangeNotifierProvider<VideoStreamController>(
            create: (context) => VideoStreamController(
              context,
              match: args[matchKey],
              streamUrl: args[urlKey],
            ),
            child: VideoStreamView(),
          ),
        );
      case webStreamRt:
        final args = setting.arguments as dynamic;
        return MaterialPageRoute(
          settings: RouteSettings(name: webStreamRt),
          builder: (context) => ChangeNotifierProvider<WebStreamController>(
            create: (context) =>
                WebStreamController(context, url: args[urlKey]),
            child: WebStreamView(),
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
