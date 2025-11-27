import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/illustration.svg",
            fit: BoxFit.cover,
            width: 402.w,
            height: 874.h,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 80.h),
                  Image.asset(
                    "assets/logos/logo1024.png",
                    width: 130.w,
                    fit: BoxFit.cover,
                  ).cornerRadiusWithClipRRect(12.r),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset('assets/lotties/live.json', width: 50.w),
                      Text(
                        "LiveCric HD",
                        style: Common.textStyle(isSpl: true, size: 32.sp),
                      ),
                    ],
                  ),
                ],
              ).expand(),
              Text(
                "Fetching Data...",
                style: Common.textStyle(size: 15.sp, weight: FontWeight.w600),
              ),
              SizedBox(height: 10.h),
              LinearProgressIndicator(
                minHeight: 5,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(primary50),
              ).cornerRadiusWithClipRRect(100.r).withWidth(170.w),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ).paddingSymmetric(vertical: 17.h),
        ],
      ),
    );
  }
}
