package com.apps.live_cric

import android.view.LayoutInflater
import android.view.View
import android.widget.*
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import com.google.android.gms.ads.nativead.MediaView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory

class NativeAdFactoryMedium(private val layoutInflater: LayoutInflater) : NativeAdFactory {
    override fun createNativeAd(
        nativeAd: NativeAd, customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val adView = layoutInflater.inflate(R.layout.native_ad_medium, null) as NativeAdView

        // Assign views
        val mediaView = adView.findViewById<MediaView>(R.id.ad_media)
        val iconView = adView.findViewById<ImageView>(R.id.ad_app_icon)
        val headlineView = adView.findViewById<TextView>(R.id.ad_headline)
        val bodyView = adView.findViewById<TextView>(R.id.ad_body)
        val ctaButton = adView.findViewById<Button>(R.id.ad_call_to_action)
        val labelView = adView.findViewById<TextView>(R.id.ad_label)

        // Set views to NativeAdView
        adView.mediaView = mediaView
        adView.headlineView = headlineView
        adView.bodyView = bodyView
        adView.callToActionView = ctaButton
        adView.iconView = iconView

        // Populate data
        headlineView.text = nativeAd.headline
        bodyView.text = nativeAd.body
        ctaButton.text = nativeAd.callToAction

        nativeAd.mediaContent?.let {
            mediaView.setMediaContent(it)
            mediaView.visibility = View.VISIBLE
        } ?: run {
            mediaView.visibility = View.GONE
        }

        nativeAd.icon?.drawable?.let {
            iconView.setImageDrawable(it)
            iconView.visibility = View.VISIBLE
        } ?: run {
            iconView.visibility = View.GONE
        }

        // Optional: set ad label if needed
        labelView?.visibility = View.VISIBLE

        // Attach the ad to the view
        adView.setNativeAd(nativeAd)

        return adView
    }
}
