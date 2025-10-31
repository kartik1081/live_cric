import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:live_cric/utils/ads.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class RemoteConfigs {
  static final _config = FirebaseRemoteConfig.instance;

  static final defaulValue = {
    "app_name": 'LiveCric',
    "x-rapidapi-host": "cricbuzz-cricket.p.rapidapi.com",
    "x-rapidapi-key": "c89783400cmsh40a6a97cc3e0dd4p11104bjsnd09af3840a52",
    "show_banner": true,
    "show_native": true,
    "show_interstitial": true,
    "show_reward": true,
    "banner_id": "ca-app-pub-3940256099942544/6300978111",
    "native_id": "ca-app-pub-3940256099942544/2247696110",
    "interstitial_id": "ca-app-pub-3940256099942544/1033173712",
    "reward_id": "ca-app-pub-3940256099942544/5224354917",
  };

  static String get appNameRc => _config.getString("app_name");
  static String get xRapidapiHostRc => _config.getString("x-rapidapi-host");
  static String get xRapidapiKeyRc => _config.getString("x-rapidapi-key");
  static bool get showBannerRc => _config.getBool("show_banner");
  static bool get showNativeRc => _config.getBool("show_native");
  static bool get showInterstitialRc => _config.getBool("show_interstitial");
  static bool get showRewardRc => _config.getBool("show_reward");
  static String get bannerIdRc => _config.getString("banner_id");
  static String get nativeIdRc => _config.getString("native_id");
  static String get interstitialIdRc => _config.getString("interstitial_id");
  static String get rewardedIdRc => _config.getString("reward_id");

  static Future<void> initConfig() async {
    try {
      await _config.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 1),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );

      await _config.setDefaults(defaulValue);

      _config.onConfigUpdated.listen((event) async {
        await _config.activate();
      });
    } on PlatformException catch (e) {
      nb.log("initConfig: $e");
    } catch (e) {
      nb.log("initConfig: $e");
    } finally {
      Ads.loadInterstitial();
      Ads.loadReward();
    }
  }
}
