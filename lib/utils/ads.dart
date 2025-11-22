import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class Ads {
  static bool adPermission = true;
  static InterstitialAd? interstitialAd;
  static RewardedAd? rewardedAd;

  static bool _isLoadingInterstitial = false;
  static bool _isLoadingRewarded = false;

  static void updateAdStatus(bool loadAds) {
    adPermission = loadAds;
    if (adPermission) {
      loadReward();
      loadInterstitial();
    } else {
      // Ads.interstitialAd?.dispose();
      // Ads.rewardedAd?.dispose();
      // Ads.interstitialAd = null;
      // Ads.rewardedAd = null;
    }
  }

  static Future<void> showInterstitialAd(
    bool show, {
    VoidCallback? onDismiss,
    VoidCallback? onFail,
  }) async {
    if (!show || !adPermission) {
      if (onDismiss != null) onDismiss();
      return;
    }

    if (Ads.interstitialAd != null) {
      Ads.interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) async {
          nb.log("Ads: Interstitial onAdDismissedFullScreenContent");
          if (onDismiss != null) onDismiss();
          ad.dispose();
          interstitialAd?.dispose();
          interstitialAd = null;
          loadInterstitial();
        },
        onAdImpression: (ad) {
          nb.log("Ads: Interstitial Impression");
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          interstitialAd?.dispose();
          interstitialAd = null;
        },

        onAdWillDismissFullScreenContent: (ad) {
          interstitialAd?.dispose();
          interstitialAd = null;
        },
      );
      await Ads.interstitialAd?.show();
      await Future.delayed(300.milliseconds);
    } else {
      if (onDismiss != null) onDismiss();
      Ads.interstitialAd?.dispose();
      Ads.interstitialAd = null;
      Ads.loadInterstitial();
    }
  }

  static Future<void> showRewardedAd() async {
    if (Ads.rewardedAd != null && adPermission) {
      Ads.rewardedAd?.show(onUserEarnedReward: (ad, reward) {});
      await Future.delayed(300.milliseconds);
    }
  }

  static void retryReward() {
    Ads.rewardedAd?.dispose();
    Ads.rewardedAd = null;
    Ads.loadReward();
  }

  static void loadInterstitial() async {
    if (!RemoteConfigs.showInterstitialRc || !adPermission) return;
    if (interstitialAd != null || _isLoadingInterstitial) return;

    _isLoadingInterstitial = true;

    try {
      InterstitialAd.load(
        adUnitId: RemoteConfigs.interstitialIdRc,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _isLoadingInterstitial = false;

            interstitialAd = ad;
          },
          onAdFailedToLoad: (err) {
            _isLoadingInterstitial = false;
            nb.log("Ads: Interstitial Failed");
            interstitialAd?.dispose();
            interstitialAd = null;
          },
        ),
      );
    } catch (e) {
      nb.log("loadInterstitial: $e");
    } finally {}
  }

  static void loadReward() async {
    if (!RemoteConfigs.showRewardRc || !adPermission) return;
    if (rewardedAd != null || _isLoadingRewarded) return;

    _isLoadingRewarded = true;

    try {
      RewardedAd.load(
        adUnitId: RemoteConfigs.rewardedIdRc,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            _isLoadingRewarded = false;

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) async {},
              onAdImpression: (ad) {
                nb.log("Ads: Rewarded Impression");
                ad.dispose();
                rewardedAd?.dispose();
                rewardedAd = null;
                loadReward();
              },
              onAdWillDismissFullScreenContent: (ad) {
                rewardedAd?.dispose();
                rewardedAd = null;
              },
            );
            rewardedAd = ad;
          },
          onAdFailedToLoad: (err) {
            _isLoadingRewarded = false;

            nb.log("Ads: Rewarded Failed");
            rewardedAd?.dispose();
            rewardedAd = null;
          },
        ),
      );
    } catch (e) {
      nb.log("loadReward: $e");
    } finally {}
  }
}
