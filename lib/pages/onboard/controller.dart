import 'package:flutter/widgets.dart';
import 'package:live_cric/utils/common.dart';
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
    Common.tapListener();
    ++_currentIndex;
    if (_currentIndex >= 3) {
      nb.setValue(onboardKey, true);
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.privacyConsentRt,
        (route) => false,
      );
      return;
    }
    notify();
    pageController.animateToPage(
      _currentIndex,
      duration: 300.milliseconds,
      curve: Curves.ease,
    );
  }

  void notify() {
    if (_mounted) notifyListeners();
  }
}
