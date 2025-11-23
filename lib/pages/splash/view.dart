import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/remote_configs.dart';
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
                    RemoteConfigs.appNameRc,
                    style: Common.textStyle(isSpl: true, size: 32.sp),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
