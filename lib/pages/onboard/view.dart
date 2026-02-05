import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/pages/onboard/controller.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/widgets/custom_native.dart';
import 'package:nb_utils/nb_utils.dart' hide black;
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';

class OnboardView extends StatelessWidget {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OnboardController>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          CustomNative(
            nativeType: nativeMedium,
            nativeId: RemoteConfigs.nativeAdRc.adId,
            showNative: true,
            bannerType: AdSize.mediumRectangle,
            bannerId: RemoteConfigs.bannerAdRc.adId,
            showBanner: true,
            bottomPadding: 13,
          ),
          SizedBox(height: 16.sp),
          Selector<OnboardController, int>(
            selector: (p0, p1) => p1.currentIndex,
            builder: (context, currentIndex, child) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 15.h,
                  width: 15.w,
                  decoration: BoxDecoration(
                    color: currentIndex >= 0 ? soft : popUp,
                    borderRadius: nb.radius(100.r),
                  ),
                ),
                SizedBox(width: 7.w),
                Container(
                  height: 15.h,
                  width: 15.w,
                  decoration: BoxDecoration(
                    color: currentIndex >= 1 ? soft : popUp,
                    borderRadius: nb.radius(100.r),
                  ),
                ),
                SizedBox(width: 7.w),
                Container(
                  height: 15.h,
                  width: 15.w,
                  decoration: BoxDecoration(
                    color: currentIndex >= 2 ? soft : popUp,
                    borderRadius: nb.radius(100.r),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.sp),
          PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Welcome to live cricket score",
                    style: Common.textStyle(isSpl: true, size: 20.sp),
                  ),
                  SizedBox(height: 13.h),
                  Text(
                    "Stay in the game with our real-time\nCricket score app,\nget up-to the minute updateson matches\nfrom around the world.",
                    textAlign: TextAlign.center,
                    style: Common.textStyle(size: 14.sp, color: text),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Explore the world of cricket",
                    style: Common.textStyle(isSpl: true, size: 20.sp),
                  ),
                  SizedBox(height: 13.h),
                  Text(
                    "Dive into the thrilling world of Cricket with our app, we're here to make your Cricket experience unforgettable.",
                    textAlign: TextAlign.center,
                    style: Common.textStyle(size: 14.sp, color: text),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Real time cricket score updates",
                    style: Common.textStyle(isSpl: true, size: 20.sp),
                  ),
                  SizedBox(height: 13.h),
                  Text(
                    "With our app, you'll always be ahead\nof the game when it comes to\nCricket scores and match information.",
                    textAlign: TextAlign.center,
                    style: Common.textStyle(size: 14.sp, color: text),
                  ),
                ],
              ),
            ],
          ).flexible(),
          Container(
            width: 402.w,
            height: 45.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primary50,
              borderRadius: nb.radius(12.r),
            ),
            child: Text(
              "Next",
              style: Common.textStyle(
                color: black,
                weight: FontWeight.bold,
                size: 18.sp,
              ),
            ),
          ).onTap(() => controller.updateIndex(context)),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h),
        ],
      ).paddingSymmetric(horizontal: 22.w),
    );
  }
}
