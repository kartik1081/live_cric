import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:live_cric/utils/ads.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class RemoteConfigs {
  static final _config = FirebaseRemoteConfig.instance;

  static final defaulValue = {
    "app_name": 'LiveCric HD',
    "x_rapidapi_host": "cricbuzz-cricket.p.rapidapi.com",
    "x_rapidapi_key": "1c5003a597msh0995e6efae78e63p14d451jsn61dd1d7d694f",
    "show_app_open": true,
    "show_banner": true,
    "show_native": true,
    "show_interstitial": true,
    "show_reward": true,
    "app_open_id": "ca-app-pub-7330756705387601/6114357528",
    "banner_id": "ca-app-pub-7330756705387601/5989292496",
    "native_id": "ca-app-pub-7330756705387601/6019537493",
    "interstitial_id": "ca-app-pub-7330756705387601/3363129155",
    "reward_id": "ca-app-pub-7330756705387601/5072738598",
    // "app_open_id": "ca-app-pub-3940256099942544/9257395921",
    // "banner_id": "ca-app-pub-3940256099942544/6300978111",
    // "native_id": "ca-app-pub-3940256099942544/5224354917",
    // "interstitial_id": "ca-app-pub-3940256099942544/1033173712",
    // "reward_id": "ca-app-pub-7330756705387601/5072738598",
    "demo_stream": false,
  };

  static String get appNameRc => _config.getString("app_name");
  static String get xRapidapiHostRc => _config.getString("x_rapidapi_host");
  static String get xRapidapiKeyRc => _config.getString("x_rapidapi_key");
  static bool get showAppOpenRc => _config.getBool("show_app_open");
  static bool get showBannerRc => _config.getBool("show_banner");
  static bool get showNativeRc => _config.getBool("show_native");
  static bool get showInterstitialRc => _config.getBool("show_interstitial");
  static bool get showRewardRc => _config.getBool("show_reward");
  static String get appOpenIdRc => _config.getString("app_open_id");
  static String get bannerIdRc => _config.getString("banner_id");
  static String get nativeIdRc => _config.getString("native_id");
  static String get interstitialIdRc => _config.getString("interstitial_id");
  static String get rewardedIdRc => _config.getString("reward_id");
  static bool get demoStreamRc => _config.getBool("demo_stream");

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
