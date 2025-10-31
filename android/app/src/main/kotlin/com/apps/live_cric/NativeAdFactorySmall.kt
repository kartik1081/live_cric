package com.apps.live_cric

import android.view.LayoutInflater
import android.view.View
import android.widget.*
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory

class NativeAdFactorySmall(private val layoutInflater: LayoutInflater) : NativeAdFactory {
    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val adView = layoutInflater.inflate(R.layout.native_ad_small, null) as NativeAdView

        // Bind views
        val iconView = adView.findViewById<ImageView>(R.id.ad_app_icon)
        val headlineView = adView.findViewById<TextView>(R.id.ad_headline)
        val bodyView = adView.findViewById<TextView>(R.id.ad_body)
        val ctaView = adView.findViewById<Button>(R.id.ad_call_to_action)

        // Set native ad assets
        adView.iconView = iconView
        adView.headlineView = headlineView
        adView.bodyView = bodyView
        adView.callToActionView = ctaView

        // Headline
        headlineView.text = nativeAd.headline

        // Body (optional)
        if (!nativeAd.body.isNullOrEmpty()) {
            bodyView.text = nativeAd.body
            bodyView.visibility = View.VISIBLE
        } else {
            bodyView.visibility = View.GONE
        }

        // Icon
        nativeAd.icon?.drawable?.let {
            iconView.setImageDrawable(it)
            iconView.visibility = View.VISIBLE
        } ?: run {
            iconView.visibility = View.GONE
        }

        // CTA
        nativeAd.callToAction?.let {
            ctaView.text = it
            ctaView.visibility = View.VISIBLE
        } ?: run {
            ctaView.visibility = View.GONE
        }

        // Register native ad
        adView.setNativeAd(nativeAd)

        return adView
    }
}
