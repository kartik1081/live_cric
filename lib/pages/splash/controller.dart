import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/configs.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/routes.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class SplashController extends ChangeNotifier {
  SplashController(BuildContext context) {
    Common.initAds();
    Configs.messaging.subscribeToTopic("live_cric");
    Future.delayed(3.seconds).whenComplete(() {
      if (context.mounted) {
        loadAppOpenAd(() async {
          Navigator.pushNamedAndRemoveUntil(
            context,
            nb.getBoolAsync(onboardKey, defaultValue: false)
                ? nb.getBoolAsync(privacyConsentKey, defaultValue: false)
                      ? nb.getStringAsync(selectedCountryKey) == ""
                            ? Routes.selectCountryRt
                            : Routes.homeRt
                      : Routes.privacyConsentRt
                : Routes.onboardRt,
            (route) => false,
          );
        });
      }
    });
  }

  void loadAppOpenAd(VoidCallback onDone) {
    if (RemoteConfigs.showAppOpenRc) {
      AppOpenAd.load(
        adUnitId: RemoteConfigs.appOpenIdRc,
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) async {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) => onDone(),
              onAdFailedToShowFullScreenContent: (ad, error) => onDone(),
            );
            ad.show();
          },
          onAdFailedToLoad: (error) => onDone(),
        ),
      );
    } else {
      onDone();
    }
  }
}
