import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/models/crt/crt_match_info.dart';
import 'package:live_cric/models/crt/crt_match_scorecard_model.dart';
import 'package:live_cric/pages/scorecard/controller.dart';
import 'package:live_cric/pages/scorecard/widgets/custom_expantion_tile.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/widgets/custom_native.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';

class ScorecardView extends StatelessWidget {
  const ScorecardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: soft,
                  size: 23.w,
                ),
              ),
              SizedBox(width: 7.w),
              Text(
                "Scorecard",
                style: Common.textStyle(isSpl: true, size: 22.sp),
              ),
            ],
          ),
          SizedBox(height: 13.h),
          Selector<ScorecardController, bool>(
            selector: (p0, p1) => p1.loading,
            builder: (context, loading, child) => loading
                ? Common.loader().paddingBottom(100.h)
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Selector<ScorecardController, CrtMatchScorecardModel?>(
                          selector: (p0, p1) => p1.scorecardModel,
                          builder: (context, scorecardModel, child) =>
                              scorecardModel == null
                              ? const SizedBox.shrink()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      scorecardModel.status,
                                      style: Common.textStyle(
                                        color: Colors.orange,
                                        size: 17.sp,
                                      ),
                                    ).paddingSymmetric(horizontal: 22.w),
                                    ...List.generate(
                                      scorecardModel.inningList.length,
                                      (index) => CustomExpantionTile(
                                        inning:
                                            scorecardModel.inningList[index],
                                        initiallyExpanded:
                                            index ==
                                            scorecardModel.inningList.length -
                                                1,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        Selector<ScorecardController, CrtMatchInfoModel?>(
                          selector: (p0, p1) => p1.matchInfo,
                          builder: (context, matchInfo, child) => Column(
                            children: [
                              if (matchInfo != null) ...[
                                SizedBox(height: 16.h),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      55,
                                      250,
                                      209,
                                      28,
                                    ),
                                  ),
                                  child:
                                      Text(
                                        "Info",
                                        style: Common.textStyle(
                                          size: 17.sp,
                                          weight: FontWeight.w700,
                                        ),
                                      ).paddingSymmetric(
                                        horizontal: 13.sp,
                                        vertical: 17.h,
                                      ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Match",
                                      style: Common.textStyle(
                                        weight: FontWeight.w600,
                                      ),
                                    ).expand(flex: 2),
                                    Text(
                                      "${matchInfo.matchDesc}  ●  ${matchInfo.seriesName}",
                                      style: Common.textStyle(),
                                    ).expand(flex: 6),
                                  ],
                                ).paddingSymmetric(
                                  horizontal: 13.w,
                                  vertical: 10.h,
                                ),
                                Divider(color: text, thickness: 0.5, height: 0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Series",
                                      style: Common.textStyle(
                                        weight: FontWeight.w600,
                                      ),
                                    ).expand(flex: 2),
                                    Text(
                                      matchInfo.seriesName,
                                      style: Common.textStyle(),
                                    ).expand(flex: 6),
                                  ],
                                ).paddingSymmetric(
                                  horizontal: 13.w,
                                  vertical: 10.h,
                                ),
                                Divider(color: text, thickness: 0.5, height: 0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date",
                                      style: Common.textStyle(
                                        weight: FontWeight.w600,
                                      ),
                                    ).expand(flex: 2),
                                    Text(
                                      matchInfo.startedAtDate,
                                      style: Common.textStyle(),
                                    ).expand(flex: 6),
                                  ],
                                ).paddingSymmetric(
                                  horizontal: 13.w,
                                  vertical: 10.h,
                                ),
                                Divider(color: text, thickness: 0.5, height: 0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Time",
                                      style: Common.textStyle(
                                        weight: FontWeight.w600,
                                      ),
                                    ).expand(flex: 2),
                                    Text(
                                      "${matchInfo.startedAtTime} Local",
                                      style: Common.textStyle(),
                                    ).expand(flex: 6),
                                  ],
                                ).paddingSymmetric(
                                  horizontal: 13.w,
                                  vertical: 10.h,
                                ),
                                Divider(color: text, thickness: 0.5, height: 0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Toss",
                                      style: Common.textStyle(
                                        weight: FontWeight.w600,
                                      ),
                                    ).expand(flex: 2),
                                    Text(
                                      matchInfo.tossStatus,
                                      style: Common.textStyle(),
                                    ).expand(flex: 6),
                                  ],
                                ).paddingSymmetric(
                                  horizontal: 13.w,
                                  vertical: 10.h,
                                ),
                                Divider(color: text, thickness: 0.5, height: 0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Venue",
                                      style: Common.textStyle(
                                        weight: FontWeight.w600,
                                      ),
                                    ).expand(flex: 2),
                                    Text(
                                      matchInfo.venue,
                                      style: Common.textStyle(),
                                    ).expand(flex: 6),
                                  ],
                                ).paddingSymmetric(
                                  horizontal: 13.w,
                                  vertical: 10.h,
                                ),
                                Divider(color: text, thickness: 0.5, height: 0),
                                if (matchInfo.umpire1 != null ||
                                    matchInfo.umpire2 != null) ...[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Umpire",
                                        style: Common.textStyle(
                                          weight: FontWeight.w600,
                                        ),
                                      ).expand(flex: 2),
                                      Text(
                                        "${matchInfo.umpire1!.name}, ${matchInfo.umpire2!.name}",
                                        style: Common.textStyle(),
                                      ).expand(flex: 6),
                                    ],
                                  ).paddingSymmetric(
                                    horizontal: 13.w,
                                    vertical: 10.h,
                                  ),
                                  Divider(
                                    color: text,
                                    thickness: 0.5,
                                    height: 0,
                                  ),
                                ],
                                if (matchInfo.umpire3 != null) ...[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "3rd Umpire",
                                        style: Common.textStyle(
                                          weight: FontWeight.w600,
                                        ),
                                      ).expand(flex: 2),
                                      Text(
                                        matchInfo.umpire3!.name,
                                        style: Common.textStyle(),
                                      ).expand(flex: 6),
                                    ],
                                  ).paddingSymmetric(
                                    horizontal: 13.w,
                                    vertical: 10.h,
                                  ),
                                  Divider(
                                    color: text,
                                    thickness: 0.5,
                                    height: 0,
                                  ),
                                ],
                                if (matchInfo.referee != null) ...[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Referee",
                                        style: Common.textStyle(
                                          weight: FontWeight.w600,
                                        ),
                                      ).expand(flex: 2),
                                      Text(
                                        matchInfo.referee!.name,
                                        style: Common.textStyle(),
                                      ).expand(flex: 6),
                                    ],
                                  ).paddingSymmetric(
                                    horizontal: 13.w,
                                    vertical: 10.h,
                                  ),
                                  Divider(
                                    color: text,
                                    thickness: 0.5,
                                    height: 0,
                                  ),
                                ],
                              ],
                            ],
                          ),
                        ),
                        SizedBox(height: 150.h),
                      ],
                    ),
                  ),
          ).expand(),
          CustomNative(
            nativeType: "",
            bannerType: AdSize.fullBanner,
            nativeId: "",
            bannerId: RemoteConfigs.bannerIdRc,
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
