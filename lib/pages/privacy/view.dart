import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/pages/privacy/controller.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/widgets/custom_native.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PrivacyController>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 35.h),
          Row(
            children: [
              SizedBox(width: 7.w),
              Text(
                "Privacy Consent",
                style: Common.textStyle(isSpl: true, size: 22.sp),
              ),
            ],
          ).paddingSymmetric(horizontal: 22.w),
          SizedBox(height: 10.h),
          Selector<PrivacyController, bool>(
            selector: (p0, p1) => p1.loading,
            builder: (context, loading, child) => loading
                ? Common.loader()
                : WebViewWidget(
                    controller: Provider.of<PrivacyController>(
                      context,
                      listen: false,
                    ).controller!,
                  ),
          ).expand(),
          Column(
            children: [
              Row(
                children: [
                  Selector<PrivacyController, bool>(
                    selector: (p0, p1) => p1.checked,
                    builder: (context, checked, child) => Checkbox(
                      checkColor: black,
                      fillColor: WidgetStateProperty.resolveWith<Color?>((
                        Set<WidgetState> states,
                      ) {
                        if (states.contains(WidgetState.selected)) {
                          return primary50; // Color when selected
                        }

                        return black; // Default color when unselected
                      }),
                      value: checked,
                      onChanged: (value) => controller.updateCheck(),
                    ),
                  ),
                  Text(
                    "I read and accepted the privacy policy",
                    style: Common.textStyle(
                      color: text,
                      size: 15.sp,
                      weight: FontWeight.w600,
                    ),
                  ).expand(),
                ],
              ).onTap(() => controller.updateCheck()),
              Container(
                width: 402.w,
                height: 45.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primary50,
                  borderRadius: nb.radius(12.r),
                ),
                child: Text(
                  "Agree & Next",
                  style: Common.textStyle(
                    color: black,
                    weight: FontWeight.bold,
                    size: 18.sp,
                  ),
                ),
              ).onTap(() => controller.onSubmit(context)),
              CustomNative(
                nativeType: nativeSmall,
                bannerType: AdSize.fullBanner,
                nativeId: RemoteConfigs.nativeIdRc,
                bannerId: RemoteConfigs.bannerIdRc,
              ),
              SizedBox(height: 13.h),
            ],
          ).paddingSymmetric(horizontal: 22.w),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
