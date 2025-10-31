import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/models/crt/crt_match_scorecard_model.dart';
import 'package:live_cric/pages/video_stream/controller.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/widgets/custom_native.dart';
import 'package:live_cric/utils/widgets/custom_network_image.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class VideoStreamView extends StatelessWidget {
  const VideoStreamView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // onPopInvokedWithResult: (didPop, result) {},
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          body: Selector<VideoStreamController, bool>(
            selector: (p0, p1) => p1.initialLoading,
            builder: (context, initialLoading, child) => initialLoading
                ? Common.loader()
                : Column(
                    children: [
                      Stack(
                        children: [
                          BetterPlayer(
                            controller: Provider.of<VideoStreamController>(
                              context,
                              listen: false,
                            ).controller,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10.w),
                                    child: Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: soft,
                                      size: 23.w,
                                    ),
                                  ).onTap(() => Navigator.pop(context)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(height: 16.h),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 13.h,
                            ),
                            decoration: BoxDecoration(
                              color: popUp,
                              borderRadius: nb.radius(12.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            Provider.of<VideoStreamController>(
                                              context,
                                              listen: false,
                                            ).match.team1.teamName,
                                        style: Common.textStyle(
                                          color: soft,
                                          size: 18.sp,
                                          weight: FontWeight.w700,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "  vs  ",
                                        style: Common.textStyle(
                                          color: soft,
                                          size: 16.sp,
                                          weight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            Provider.of<VideoStreamController>(
                                              context,
                                              listen: false,
                                            ).match.team2.teamName,
                                        style: Common.textStyle(
                                          color: soft,
                                          size: 18.sp,
                                          weight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  Provider.of<VideoStreamController>(
                                    context,
                                    listen: false,
                                  ).match.seriesName,
                                  style: Common.textStyle(color: text),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      CustomNetworkImage(
                                        imageId:
                                            Provider.of<VideoStreamController>(
                                              context,
                                              listen: false,
                                            ).match.team1.imageId,
                                        width: 47.w,
                                        height: 35.h,
                                      ),
                                      SizedBox(height: 7.h),
                                      Text(
                                        Provider.of<VideoStreamController>(
                                          context,
                                          listen: false,
                                        ).match.team1.teamSName,
                                        style: Common.textStyle(
                                          color: soft,
                                          size: 14.sp,
                                          weight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 7.w),
                                  Column(
                                    children: List.generate(
                                      Provider.of<VideoStreamController>(
                                        context,
                                        listen: false,
                                      ).match.team1Scores.length,
                                      (index) => Row(
                                        children: [
                                          Text(
                                            "${Provider.of<VideoStreamController>(context, listen: false).match.team1Scores[index].runs} / ${Provider.of<VideoStreamController>(context, listen: false).match.team1Scores[index].wickets}",
                                            style: Common.textStyle(
                                              color: soft,
                                              size: 18.sp,
                                              weight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            "  (${Provider.of<VideoStreamController>(context, listen: false).match.team1Scores[index].overs})",
                                            style: Common.textStyle(
                                              color: text,
                                              size: 12.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ).expand(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: List.generate(
                                      Provider.of<VideoStreamController>(
                                        context,
                                        listen: false,
                                      ).match.team2Scores.length,
                                      (index) => Row(
                                        children: [
                                          Text(
                                            "${Provider.of<VideoStreamController>(context, listen: false).match.team2Scores[index].runs} / ${Provider.of<VideoStreamController>(context, listen: false).match.team2Scores[index].wickets}",
                                            style: Common.textStyle(
                                              color: soft,
                                              size: 18.sp,
                                              weight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "  (${Provider.of<VideoStreamController>(context, listen: false).match.team2Scores[index].overs})",
                                            style: Common.textStyle(
                                              color: text,
                                              size: 12.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 7.w),
                                  Column(
                                    children: [
                                      CustomNetworkImage(
                                        imageId:
                                            Provider.of<VideoStreamController>(
                                              context,
                                              listen: false,
                                            ).match.team2.imageId,
                                        width: 47.w,
                                        height: 35.h,
                                      ),
                                      SizedBox(height: 7.h),
                                      Text(
                                        Provider.of<VideoStreamController>(
                                          context,
                                          listen: false,
                                        ).match.team2.teamSName,
                                        style: Common.textStyle(
                                          color: soft,
                                          size: 14.sp,
                                          weight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ).expand(),
                            ],
                          ).paddingOnly(
                            left: 7.w,
                            right: 7.w,
                            top: 16.h,
                            bottom: 7.h,
                          ),
                          Text(
                            Provider.of<VideoStreamController>(
                              context,
                              listen: false,
                            ).match.status,
                            style: Common.textStyle(color: Colors.orange),
                          ),
                          SizedBox(height: 7.h),
                          Selector<
                                VideoStreamController,
                                Tuple2<bool, CrtMatchScorecardModel?>
                              >(
                                selector: (p0, p1) => Tuple2(
                                  p1.scorecardLoading,
                                  p1.scorecardModel,
                                ),
                                builder: (context, data, child) => data.item1
                                    ? Common.loader().paddingBottom(100.h)
                                    : DefaultTabController(
                                        length:
                                            data.item2?.inningList.length ?? 0,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(
                                            children: [
                                              SizedBox(height: 11.h),
                                              CustomNative(
                                                nativeType: nativeSmall,
                                                nativeId:
                                                    RemoteConfigs.nativeIdRc,
                                                showNative: true,
                                                bannerType: AdSize.largeBanner,
                                                bannerId:
                                                    RemoteConfigs.bannerIdRc,
                                                showBanner: true,
                                                bottomPadding: 13,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              )
                              .expand(),
                        ],
                      ).paddingSymmetric(horizontal: 18.w).expand(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
