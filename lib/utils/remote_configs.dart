import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:live_cric/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class RemoteConfigs {
  static final _config = FirebaseRemoteConfig.instance;

  static final defaulValue = {
    "app_name": 'LiveCric HD',
    "x_rapidapi_host": "cricbuzz-cricket.p.rapidapi.com",
    "x_rapidapi_key": "c89783400cmsh40a6a97cc3e0dd4p11104bjsnd09af3840a52",
    "show_app_open": true,
    "show_banner": true,
    "show_native": true,
    "show_interstitial": true,
    "show_reward": true,
    // "app_open_id": "ca-app-pub-7330756705387601/6114357528",
    // "banner_id": "ca-app-pub-7330756705387601/5989292496",
    // "native_id": "ca-app-pub-7330756705387601/6019537493",
    // "interstitial_id": "ca-app-pub-3940256099942544/1033173712",
    // "reward_id": "ca-app-pub-7330756705387601/5072738598",
    "app_open_id": "ca-app-pub-4263828040563949/8545070975",
    "banner_id": "ca-app-pub-4263828040563949/2282204517",
    "native_id": "ca-app-pub-4263828040563949/8009173916",
    "interstitial_id": "ca-app-pub-4263828040563949/9969122844",
    "reward_id": "ca-app-pub-4263828040563949/7426704079",
    "privacy_policy":
        "https://sites.google.com/view/shubhmangal-textile/livecrichd-privacy-policy",
    "new_update": false,
    "version_code": 3,
    "version_name": "1.0.0",
    "show_copyright": true,
    "interstitial_ad_interval": 300,
    "event": jsonEncode({}),
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
  static String get privacyPolicyRc => _config.getString("privacy_policy");
  static bool get newUpdateRc => _config.getBool("new_update");
  static int get versionCodeRc => _config.getInt("version_code");
  static String get versionNameRc => _config.getString("version_name");
  static bool get showCopyrightRc => _config.getBool("show_copyright");
  static int get interstitialAdIntervalRc =>
      _config.getInt("interstitial_ad_interval");
  static Map<dynamic, dynamic> get eventRc =>
      jsonDecode(_config.getString("event"));

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
    } on PlatformException catch (e, s) {
      nb.log("initConfig: $e");
      Configs.crashlytics.recordError(e, s, reason: "initConfig");
    } catch (e, s) {
      nb.log("initConfig: $e");
      Configs.crashlytics.recordError(e, s, reason: "initConfig");
    } finally {}
  }
}
