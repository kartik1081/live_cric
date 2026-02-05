import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/utils/configs.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class Ads {
  static bool adPermission = true;

  static bool _isLoadingInterstitial = false;

  static void loadInterstitial() async {
    if (!RemoteConfigs.interstitialAdRc.show || !adPermission) return;
    if (_isLoadingInterstitial) return;

    _isLoadingInterstitial = true;

    try {
      InterstitialAd.load(
        adUnitId: RemoteConfigs.interstitialAdRc.adId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _isLoadingInterstitial = false;
            ad.show();
          },
          onAdFailedToLoad: (err) {
            _isLoadingInterstitial = false;
            nb.log("Ads: Interstitial Failed");
          },
        ),
      );
    } catch (e, s) {
      nb.log("loadInterstitial: $e");
      Configs.crashlytics.recordError(e, s, reason: "loadInterstitial");
    } finally {}
  }
}
