import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/pages/team_info/controller.dart';
import 'package:live_cric/pages/team_info/widgets/schedule_tile.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/routes.dart';
import 'package:live_cric/utils/widgets/custom_native.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';

class TeamInfoView extends StatelessWidget {
  const TeamInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TeamInfoController>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30.h),
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: soft,
                  size: 23.w,
                ),
              ),
              SizedBox(width: 7.w),
              nb.Marquee(
                child: Text(
                  "Team ${controller.team.countryName}'s Info",
                  style: Common.textStyle(isSpl: true, size: 22.sp),
                ),
              ).expand(),
            ],
          ),
          SizedBox(height: 7.h),
          Row(
            children: [
              Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Schedules",
                      style: Common.textStyle(
                        color: soft,
                        size: 16.sp,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Divider(height: 0, color: soft, thickness: 2).withWidth(60.w),
                ],
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.playerListRt,
                  arguments: {teamKey: controller.team},
                ),
                child: Text(
                  "Players",
                  style: Common.textStyle(
                    color: text,
                    size: 16.sp,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.teamNewsRt,
                  arguments: {teamKey: controller.team},
                ),
                child: Text(
                  "News",
                  style: Common.textStyle(
                    color: text,
                    size: 16.sp,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 18.w),
          Divider(color: text, thickness: 0.2, height: 0),
          Selector<TeamInfoController, bool>(
            selector: (p0, p1) => p1.loading,
            builder: (context, loading, child) => loading
                ? Common.loader()
                : Selector<TeamInfoController, List<dynamic>>(
                    builder: (context, schedules, child) => ListView.separated(
                      itemCount: schedules.length,
                      padding: EdgeInsets.only(top: 7.h, bottom: 150.h),
                      itemBuilder: (context, index) => schedules[index] == null
                          ? CustomNative(
                              nativeType: nativeSmall,
                              bannerType: AdSize.fullBanner,
                              nativeId: RemoteConfigs.nativeAdRc.adId,
                              bannerId: RemoteConfigs.bannerAdRc.adId,
                            ).paddingSymmetric(horizontal: 22.w)
                          : ScheduleTile(schedule: schedules[index]),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 13.h),
                    ),
                    selector: (p0, p1) => p1.schedules,
                  ),
          ).expand(),
          CustomNative(
            nativeType: "",
            bannerType: AdSize.fullBanner,
            nativeId: "",
            bannerId: RemoteConfigs.bannerAdRc.adId,
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
