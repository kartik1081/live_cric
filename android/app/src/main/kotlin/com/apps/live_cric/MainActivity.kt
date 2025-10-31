package com.apps.live_cric

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine,
            "nativeAdFactorySmall",
            NativeAdFactorySmall(layoutInflater)
        )

        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine,
            "nativeAdFactoryMedium",
            NativeAdFactoryMedium(layoutInflater)
        )
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine,
            "nativeAdFactoryVideo",
            NativeAdFactoryVideo(layoutInflater)
        )
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        // Unregister both factories to avoid memory leaks
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "nativeAdFactorySmall")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "nativeAdFactoryMedium")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "nativeAdFactoryVideo")

        super.cleanUpFlutterEngine(flutterEngine)
    }
}

