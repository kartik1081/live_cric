import 'package:flutter/widgets.dart';
import 'package:live_cric/utils/ads.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/routes.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class OnboardController extends ChangeNotifier {
  late final PageController pageController;
  bool _mounted = false;
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  OnboardController() {
    _mounted = true;
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }

  void updateIndex(BuildContext context) {
    ++_currentIndex;
    notify();
    pageController.animateToPage(
      _currentIndex,
      duration: 300.milliseconds,
      curve: Curves.ease,
    );
    if (_currentIndex >= 2) {
      nb.setValue(onboardKey, true);
      Ads.showInterstitialAd(true);
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.privacyConsentRt,
        (route) => false,
      );
    }
  }

  void notify() {
    if (_mounted) notifyListeners();
  }
}
