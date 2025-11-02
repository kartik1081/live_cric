import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class CustomNative extends StatefulWidget {
  final String nativeType;
  final AdSize bannerType;
  final String nativeId;
  final String bannerId;
  final bool showNative;
  final bool showBanner;
  final int topPadding;
  final int bottomPadding;
  const CustomNative({
    super.key,
    required this.nativeType,
    required this.bannerType,
    required this.nativeId,
    required this.bannerId,
    this.showNative = true,
    this.showBanner = true,
    this.topPadding = 0,
    this.bottomPadding = 0,
  });

  @override
  State<CustomNative> createState() => _CustomNativeState();
}

class _CustomNativeState extends State<CustomNative> {
  NativeAd? _nativeAd;
  BannerAd? _bannerAd;
  bool _isNativeAdLoaded = false;
  bool _isBannerAdLoaded = false;

  @override
  void initState() {
    super.initState();

    if (RemoteConfigs.showNativeRc &&
        widget.showNative &&
        widget.nativeId != "") {
      _loadNative();
    } else if (RemoteConfigs.showBannerRc &&
        widget.showBanner &&
        widget.bannerId != "") {
      _loadBanner();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isNativeAdLoaded && _nativeAd != null
        ? Container(
            alignment: Alignment.center,

            height: widget.nativeType == nativeVideo
                ? 350
                : widget.nativeType == nativeMedium
                ? 310
                : 125,
            child: AdWidget(ad: _nativeAd!),
          ).paddingOnly(
            top: widget.topPadding == 0 ? 0 : widget.topPadding.h,
            bottom: widget.bottomPadding == 0 ? 0 : widget.bottomPadding.h,
          )
        : _isBannerAdLoaded && _bannerAd != null
        ? SizedBox(
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          ).paddingOnly(
            top: widget.topPadding == 0 ? 0 : widget.topPadding.h,
            bottom: widget.bottomPadding == 0
                ? 0
                : (widget.bottomPadding + 7).h,
          )
        : SizedBox.shrink();
  }

  void _loadNative() {
    _nativeAd = NativeAd(
      adUnitId: widget.nativeId,
      factoryId: widget.nativeType,
      nativeAdOptions: NativeAdOptions(
        videoOptions: VideoOptions(startMuted: true),
      ),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isNativeAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (RemoteConfigs.showBannerRc &&
              widget.showBanner &&
              widget.bannerId != "") {
            _loadBanner();
          }
        },
      ),
      request: AdRequest(),
    );
    _nativeAd?.load();
  }

  void _loadBanner() {
    _bannerAd = BannerAd(
      adUnitId: widget.bannerId,
      size: widget.bannerType,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );
    _bannerAd?.load();
  }
}
