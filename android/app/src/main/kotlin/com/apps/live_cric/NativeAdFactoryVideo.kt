package com.apps.live_cric

import android.view.LayoutInflater
import android.view.View
import android.widget.*
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import com.google.android.gms.ads.nativead.MediaView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory

class NativeAdFactoryVideo(private val layoutInflater: LayoutInflater) : NativeAdFactory {
    override fun createNativeAd(nativeAd: NativeAd, customOptions: MutableMap<String, Any>?): NativeAdView {
        val adView = layoutInflater.inflate(R.layout.native_ad_video, null) as NativeAdView

        // Find views
        val headlineView = adView.findViewById<TextView>(R.id.ad_headline)
        val mediaView = adView.findViewById<MediaView>(R.id.ad_media)
        val bodyView = adView.findViewById<TextView>(R.id.ad_body)
        val ctaButton = adView.findViewById<Button>(R.id.ad_call_to_action)

        // Assign views to the NativeAdView
        adView.headlineView = headlineView
        adView.mediaView = mediaView
        adView.bodyView = bodyView
        adView.callToActionView = ctaButton

        // Set ad data
        headlineView.text = nativeAd.headline

        nativeAd.mediaContent?.let {
            mediaView.setMediaContent(it)
            mediaView.visibility = View.VISIBLE
        } ?: run {
            mediaView.visibility = View.GONE
        }

        nativeAd.body?.let {
            bodyView.text = it
            bodyView.visibility = View.VISIBLE
        } ?: run {
            bodyView.visibility = View.GONE
        }

        nativeAd.callToAction?.let {
            ctaButton.text = it
            ctaButton.visibility = View.VISIBLE
        } ?: run {
            ctaButton.visibility = View.GONE
        }

        // Finalize
        adView.setNativeAd(nativeAd)
        return adView
    }
}
