import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:live_cric/models/ad_model.dart';
import 'package:live_cric/utils/configs.dart';
import 'package:live_cric/utils/flaove_config.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class RemoteConfigs {
  static final _config = FirebaseRemoteConfig.instance;

  static final defaulValue = {
    "app_name": 'LiveCric HD',
    "x_rapidapi_host": "cricbuzz-cricket.p.rapidapi.com",
    "x_rapidapi_key": "c89783400cmsh40a6a97cc3e0dd4p11104bjsnd09af3840a52",
    "app_open_ad": jsonEncode({
      "show": false,
      "ad_id": "ca-app-pub-4263828040563949/8545070975",
      "ad_id_dev": "ca-app-pub-3940256099942544/9257395921",
    }),
    "banner_ad": jsonEncode({
      "show": false,
      "ad_id": "ca-app-pub-4263828040563949/2282204517",
      "ad_id_dev": "ca-app-pub-3940256099942544/6300978111",
    }),
    "native_ad": jsonEncode({
      "show": false,
      "ad_id": "ca-app-pub-4263828040563949/8009173916",
      "ad_id_dev": "ca-app-pub-3940256099942544/2247696110",
    }),
    "interstitial_ad": jsonEncode({
      "show": false,
      "ad_id": "ca-app-pub-4263828040563949/9969122844",
      "ad_id_dev": "ca-app-pub-3940256099942544/1033173712",
    }),
    "reward_ad": jsonEncode({
      "show": false,
      "ad_id":
          "/22893901953/ca-mb-app-pub-2509511211458165-tag/uswa_com.apps.live_cric_rewarded",
      "ad_id_dev": "ca-app-pub-3940256099942544/5224354917",
    }),
    "privacy_policy":
        "https://shubhmangal-29833.web.app/livecric/privacy-policy",
    "new_update": false,
    "version_code": 3,
    "version_name": "1.0.0",
    "show_copyright": true,
    "interstitial_ad_interval": 300,
    "event": jsonEncode({}),
    "default_stream_link": jsonEncode(["https://cinearena.live/live/"]),
    "admin_devices": jsonEncode([]),
    "aff_links": jsonEncode({
      "show": false,
      "tap_count": 3,
      "links": [
        "https://301-finance.fiveminutesgames.com",
        "https://300-finance.fiveminutesgames.com",
      ],
    }),
  };

  static String get appNameRc => _config.getString("app_name");
  static String get xRapidapiHostRc => _config.getString("x_rapidapi_host");
  static String get xRapidapiKeyRc => FlavorConfig.flavor == FlavorEnum.dev
      ? "560270b7edmsh3428256a4558acdp14c959jsn36664715aaab"
      : _config.getString("x_rapidapi_key");
  static AdModel get appOpenAdRc =>
      AdModel.fromJson(jsonDecode(_config.getString("app_open_ad")));
  static AdModel get bannerAdRc =>
      AdModel.fromJson(jsonDecode(_config.getString("banner_ad")));
  static AdModel get nativeAdRc =>
      AdModel.fromJson(jsonDecode(_config.getString("native_ad")));
  static AdModel get interstitialAdRc =>
      AdModel.fromJson(jsonDecode(_config.getString("interstitial_ad")));
  static AdModel get rewardedAdRc =>
      AdModel.fromJson(jsonDecode(_config.getString("interstitial_ad")));
  static String get privacyPolicyRc => _config.getString("privacy_policy");
  static bool get newUpdateRc => _config.getBool("new_update");
  static int get versionCodeRc => _config.getInt("version_code");
  static String get versionNameRc => _config.getString("version_name");
  static bool get showCopyrightRc => _config.getBool("show_copyright");
  static int get interstitialAdIntervalRc =>
      _config.getInt("interstitial_ad_interval");
  static Map<dynamic, dynamic> get eventRc =>
      jsonDecode(_config.getString("event"));
  static List<String> get defaultStreamLinkRc =>
      (jsonDecode(_config.getString("default_stream_link")) as List<dynamic>)
          .map((e) => e as String)
          .toList();
  static List<String> get adminDevicesRc =>
      (jsonDecode(_config.getString("admin_devices")) as List<dynamic>)
          .map((e) => e as String)
          .toList();
  static Map<String, dynamic> get affLinksRc =>
      jsonDecode(_config.getString("aff_links")) as Map<String, dynamic>;

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
