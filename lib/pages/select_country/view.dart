import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/pages/select_country/controller.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/widgets/custom_native.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';

class SelectCountryView extends StatelessWidget {
  const SelectCountryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SelectCountryController>(
      context,
      listen: false,
    );
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 35.h),
          Row(
            children: [
              SizedBox(width: 7.w),
              Text(
                "Select Country",
                style: Common.textStyle(isSpl: true, size: 22.sp),
              ),
            ],
          ),
          GridView.builder(
            padding: EdgeInsets.only(top: 13.h),
            itemCount: controller.countries.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 13.w,
              mainAxisSpacing: 13.h,
              childAspectRatio: 3,
            ),
            itemBuilder: (context, index) =>
                Selector<SelectCountryController, String?>(
                  selector: (p0, p1) => p1.selectedCountry,
                  shouldRebuild: (previous, next) => previous != next,
                  builder: (context, selectedCountry, child) =>
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selectedCountry == controller.countries[index]
                              ? primary50
                              : popUp,
                          borderRadius: nb.radius(12.r),
                        ),
                        child: Text(
                          controller.countries[index]!,
                          textAlign: TextAlign.center,
                          style: Common.textStyle(
                            color:
                                selectedCountry == controller.countries[index]
                                ? black
                                : soft,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ).onTap(
                        () => controller.selectCountry(
                          controller.countries[index] ?? "",
                        ),
                      ),
                ),
          ).expand(),
          SizedBox(height: 13.h),
          Container(
            width: 402.w,
            height: 45.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primary50,
              borderRadius: nb.radius(12.r),
            ),
            child: Text(
              "Select Country",
              style: Common.textStyle(
                color: black,
                weight: FontWeight.bold,
                size: 18.sp,
              ),
            ),
          ).onTap(() => controller.saveCountry(context)),
          CustomNative(
            nativeType: nativeSmall,
            bannerType: AdSize.fullBanner,
            nativeId: RemoteConfigs.nativeIdRc,
            bannerId: RemoteConfigs.bannerIdRc,
            topPadding: 7,
          ),
          SizedBox(height: 13.h),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ).paddingSymmetric(horizontal: 22.w),
    );
  }
}
