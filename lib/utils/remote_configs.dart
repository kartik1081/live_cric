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
    "banner_id": "ca-app-pub-3940256099942544/6300978111",
  };

  static String get appNameRc => _config.getString("app_name");
  static String get xRapidapiHostRc => _config.getString("x-rapidapi-host");
  static String get xRapidapiKeyRc => _config.getString("x-rapidapi-key");
  static bool get showBannerRc => _config.getBool("show_banner");
  static bool get showNativeRc => _config.getBool("show_native");
  static String get bannerIdRc => _config.getString("banner_id");

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
      Ads.initAds();
    }
  }
}
