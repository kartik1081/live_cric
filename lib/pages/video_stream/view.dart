import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/models/crt/crt_match_comm_model.dart';
import 'package:live_cric/pages/video_stream/controller.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/routes.dart';
import 'package:live_cric/utils/widgets/custom_batter_card.dart';
import 'package:live_cric/utils/widgets/custom_bowler_card.dart';
import 'package:live_cric/utils/widgets/custom_native.dart';
import 'package:live_cric/utils/widgets/custom_network_image.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';

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
                      NestedScrollView(
                        headerSliverBuilder: (context, innerBoxIsScrolled) => [
                          SliverToBoxAdapter(
                            child: Column(
                              children: [
                                SizedBox(height: 10.h),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  Provider.of<
                                                        VideoStreamController
                                                      >(context, listen: false)
                                                      .match
                                                      .team1
                                                      .teamName,
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
                                                  Provider.of<
                                                        VideoStreamController
                                                      >(context, listen: false)
                                                      .match
                                                      .team2
                                                      .teamName,
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
                                CustomNative(
                                  nativeType: nativeSmall,
                                  nativeId: RemoteConfigs.nativeAdRc.adId,
                                  showNative: true,
                                  bannerType: AdSize.largeBanner,
                                  bannerId: RemoteConfigs.bannerAdRc.adId,
                                  showBanner: true,
                                  topPadding: 11,
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 18.w),
                          ),
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: TabBarDelegate(
                              maxHeight: 55.h,
                              minHeight: 55.h,
                              child: Container(
                                color: black,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                "Commentry",
                                                style: Common.textStyle(
                                                  color: soft,
                                                  size: 16.sp,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              height: 0,
                                              color: soft,
                                              thickness: 2,
                                            ).withWidth(60.w),
                                          ],
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pushNamed(
                                            context,
                                            Routes.scorecardRt,
                                            arguments: {
                                              matchKey:
                                                  Provider.of<
                                                        VideoStreamController
                                                      >(context, listen: false)
                                                      .match,
                                            },
                                          ),
                                          child: Text(
                                            "Scorecard",
                                            style: Common.textStyle(
                                              color: text,
                                              size: 16.sp,
                                              weight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ).paddingSymmetric(horizontal: 18.w),
                                    Divider(
                                      color: text,
                                      thickness: 0.2,
                                      height: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                        body: Selector<VideoStreamController, bool>(
                          selector: (p0, p1) => p1.commentryLoading,
                          builder: (context, commentryLoading, child) =>
                              commentryLoading
                              ? Common.loader()
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  CustomNetworkImage(
                                                    imageId:
                                                        Provider.of<
                                                              VideoStreamController
                                                            >(
                                                              context,
                                                              listen: false,
                                                            )
                                                            .match
                                                            .team1
                                                            .imageId,
                                                    width: 47.w,
                                                    height: 35.h,
                                                  ),
                                                  SizedBox(height: 7.h),
                                                  Text(
                                                    Provider.of<
                                                          VideoStreamController
                                                        >(
                                                          context,
                                                          listen: false,
                                                        )
                                                        .match
                                                        .team1
                                                        .teamSName,
                                                    style: Common.textStyle(
                                                      color: soft,
                                                      size: 12.sp,
                                                      isSpl: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 7.w),
                                              if (Provider.of<
                                                    VideoStreamController
                                                  >(context, listen: false)
                                                  .match
                                                  .team1Scores
                                                  .isEmpty)
                                                Text(
                                                  "Yet to Bat",
                                                  style: Common.textStyle(
                                                    color: soft,
                                                    size: 14.sp,
                                                    weight: FontWeight.w700,
                                                  ),
                                                )
                                              else
                                                Column(
                                                  children: List.generate(
                                                    Provider.of<
                                                          VideoStreamController
                                                        >(
                                                          context,
                                                          listen: false,
                                                        )
                                                        .match
                                                        .team1Scores
                                                        .length,
                                                    (index) => Row(
                                                      children: [
                                                        Text(
                                                          "${Provider.of<VideoStreamController>(context, listen: false).match.team1Scores[index].runs} / ${Provider.of<VideoStreamController>(context, listen: false).match.team1Scores[index].wickets}",
                                                          style:
                                                              Common.textStyle(
                                                                color: soft,
                                                                size: 14.sp,
                                                                isSpl: true,
                                                              ),
                                                        ),
                                                        Text(
                                                          "  (${Provider.of<VideoStreamController>(context, listen: false).match.team1Scores[index].overs})",
                                                          style:
                                                              Common.textStyle(
                                                                color: text,
                                                                size: 11.sp,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ).expand(),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              if (Provider.of<
                                                    VideoStreamController
                                                  >(context, listen: false)
                                                  .match
                                                  .team2Scores
                                                  .isEmpty)
                                                Text(
                                                  "Yet to Bat",
                                                  style: Common.textStyle(
                                                    color: soft,
                                                    size: 14.sp,
                                                    weight: FontWeight.w700,
                                                  ),
                                                )
                                              else
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: List.generate(
                                                    Provider.of<
                                                          VideoStreamController
                                                        >(
                                                          context,
                                                          listen: false,
                                                        )
                                                        .match
                                                        .team2Scores
                                                        .length,
                                                    (index) => Row(
                                                      children: [
                                                        Text(
                                                          "${Provider.of<VideoStreamController>(context, listen: false).match.team2Scores[index].runs} / ${Provider.of<VideoStreamController>(context, listen: false).match.team2Scores[index].wickets}",
                                                          style:
                                                              Common.textStyle(
                                                                color: soft,
                                                                size: 14.sp,
                                                                isSpl: true,
                                                              ),
                                                        ),
                                                        Text(
                                                          "  (${Provider.of<VideoStreamController>(context, listen: false).match.team2Scores[index].overs})",
                                                          style:
                                                              Common.textStyle(
                                                                color: text,
                                                                size: 11.sp,
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
                                                        Provider.of<
                                                              VideoStreamController
                                                            >(
                                                              context,
                                                              listen: false,
                                                            )
                                                            .match
                                                            .team2
                                                            .imageId,
                                                    width: 47.w,
                                                    height: 35.h,
                                                  ),
                                                  SizedBox(height: 7.h),
                                                  Text(
                                                    Provider.of<
                                                          VideoStreamController
                                                        >(
                                                          context,
                                                          listen: false,
                                                        )
                                                        .match
                                                        .team2
                                                        .teamSName,
                                                    style: Common.textStyle(
                                                      color: soft,
                                                      size: 12.sp,
                                                      isSpl: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ).expand(),
                                        ],
                                      ).paddingOnly(
                                        left: 30.w,
                                        right: 30.w,
                                        top: 7.h,
                                        bottom: 7.h,
                                      ),
                                      Selector<
                                        VideoStreamController,
                                        CrtMatchCommModel?
                                      >(
                                        selector: (p0, p1) => p1.comm,
                                        builder: (context, comm, child) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if ((comm?.curovsstats ?? [])
                                                .isNotEmpty) ...[
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                padding: EdgeInsets.only(
                                                  right: 13.w,
                                                ),
                                                reverse: true,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: List.generate(
                                                    comm?.curovsstats.length ??
                                                        0,
                                                    (index) => Container(
                                                      height: 22.h,
                                                      width: 22.w,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 1.5.w,
                                                          ),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            comm!.curovsstats[index] ==
                                                                "W"
                                                            ? Colors.red
                                                            : comm.curovsstats[index] ==
                                                                      "6" ||
                                                                  comm.curovsstats[index] ==
                                                                      "4"
                                                            ? primary50
                                                            : nb.transparentColor,
                                                        borderRadius: nb.radius(
                                                          4.r,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        comm.curovsstats[index],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Common.textStyle(
                                                          size: 14.sp,
                                                          color:
                                                              comm.curovsstats[index]
                                                                      .toLowerCase() ==
                                                                  "w"
                                                              ? soft
                                                              : comm.curovsstats[index] ==
                                                                        "6" ||
                                                                    comm.curovsstats[index] ==
                                                                        "4"
                                                              ? black
                                                              : text,
                                                          weight:
                                                              comm.curovsstats[index]
                                                                          .toLowerCase() ==
                                                                      "w" ||
                                                                  comm.curovsstats[index] ==
                                                                      "6" ||
                                                                  comm.curovsstats[index] ==
                                                                      "4"
                                                              ? FontWeight.w600
                                                              : FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 13.h),
                                            ],
                                            Text(
                                              Provider.of<
                                                    VideoStreamController
                                                  >(context, listen: false)
                                                  .match
                                                  .status,
                                              style: Common.textStyle(
                                                size: 14.sp,
                                                color: Colors.orange,
                                              ),
                                            ).center(),
                                            SizedBox(height: 7.h),
                                            if ((comm
                                                        ?.matchHeaders
                                                        .momPlayers ??
                                                    [])
                                                .isNotEmpty) ...[
                                              Divider(
                                                color: text,
                                                thickness: 0.2,
                                              ),
                                              Text(
                                                "Player of the Match",
                                                style: Common.textStyle(
                                                  color: text,
                                                  size: 12,
                                                ),
                                              ),
                                              SizedBox(height: 7.h),
                                              Row(
                                                children: [
                                                  CustomNetworkImage(
                                                    imageId: int.parse(
                                                      comm!
                                                          .matchHeaders
                                                          .momPlayers
                                                          .first
                                                          .id,
                                                    ),
                                                    height: 60,
                                                    width: 60,
                                                  ).cornerRadiusWithClipRRect(
                                                    100.r,
                                                  ),
                                                  SizedBox(width: 13.w),
                                                  Text(
                                                    comm
                                                        .matchHeaders
                                                        .momPlayers
                                                        .first
                                                        .name,
                                                    style: Common.textStyle(
                                                      color: soft,
                                                      size: 16,
                                                      weight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                color: text,
                                                thickness: 0.2,
                                              ),
                                            ],
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "CRR:  ",
                                                        style: Common.textStyle(
                                                          color: text,
                                                          size: 12,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "${comm?.crr ?? 0.0}",
                                                        style: Common.textStyle(
                                                          color: soft,
                                                          size: 12,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      if (comm?.rrr != 0) ...[
                                                        TextSpan(
                                                          text: "    RRR:  ",
                                                          style:
                                                              Common.textStyle(
                                                                color: text,
                                                                size: 12,
                                                              ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "${comm?.rrr ?? 0.0}",
                                                          style:
                                                              Common.textStyle(
                                                                color: soft,
                                                                size: 12,
                                                                weight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                      ],
                                                    ],
                                                  ),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "P'SHIP:  ",
                                                        style: Common.textStyle(
                                                          color: text,
                                                          size: 12,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            comm?.partnership ??
                                                            "0(0)",
                                                        style: Common.textStyle(
                                                          color: soft,
                                                          size: 12,
                                                          weight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if (comm?.lastwkt != "") ...[
                                              SizedBox(height: 5.h),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Last Wicket\n",
                                                      style: Common.textStyle(
                                                        color: text,
                                                        size: 12,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: comm?.lastwkt ?? "",
                                                      style: Common.textStyle(
                                                        color: soft,
                                                        size: 12,
                                                        weight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                            Divider(
                                              color: text,
                                              thickness: 0.2,
                                            ),
                                            CustomBatterCard(
                                              name: "Batter",
                                              runs: "R",
                                              balls: "B",
                                              fours: "4s",
                                              sixes: "6s",
                                              sr: "SR",
                                              nameCl: text,
                                              verticalPadding: 5,
                                            ),
                                            if (comm?.strikerBatsman != null)
                                              CustomBatterCard(
                                                name:
                                                    "${comm?.strikerBatsman?.name} *",
                                                runs:
                                                    (comm
                                                                ?.strikerBatsman
                                                                ?.runs ??
                                                            0)
                                                        .toString(),
                                                balls:
                                                    (comm
                                                                ?.strikerBatsman
                                                                ?.balls ??
                                                            0)
                                                        .toString(),
                                                fours:
                                                    (comm
                                                                ?.strikerBatsman
                                                                ?.fours ??
                                                            0)
                                                        .toString(),
                                                sixes:
                                                    (comm
                                                                ?.strikerBatsman
                                                                ?.sixes ??
                                                            0)
                                                        .toString(),
                                                sr:
                                                    (comm?.strikerBatsman?.sr ??
                                                            0)
                                                        .toString(),
                                                verticalPadding: 3,
                                              ),
                                            if (comm?.nonStrikerBatsman !=
                                                    null &&
                                                comm?.nonStrikerBatsman?.id !=
                                                    0) ...[
                                              CustomBatterCard(
                                                name:
                                                    comm
                                                        ?.nonStrikerBatsman
                                                        ?.name ??
                                                    "Player",
                                                runs:
                                                    (comm
                                                                ?.nonStrikerBatsman
                                                                ?.runs ??
                                                            0)
                                                        .toString(),
                                                balls:
                                                    (comm
                                                                ?.nonStrikerBatsman
                                                                ?.balls ??
                                                            0)
                                                        .toString(),
                                                fours:
                                                    (comm
                                                                ?.nonStrikerBatsman
                                                                ?.fours ??
                                                            0)
                                                        .toString(),
                                                sixes:
                                                    (comm
                                                                ?.nonStrikerBatsman
                                                                ?.sixes ??
                                                            0)
                                                        .toString(),
                                                sr:
                                                    (comm?.nonStrikerBatsman?.sr ??
                                                            0)
                                                        .toString(),
                                                verticalPadding: 3,
                                              ),
                                            ],
                                            Divider(
                                              color: text,
                                              thickness: 0.2,
                                            ),
                                            // SizedBox(height: 16.h),
                                            CustomBowlerCard(
                                              name: "Bowler",
                                              overs: "O",
                                              maidens: "M",
                                              runs: "R",
                                              wickets: "W",
                                              eco: "ECO",
                                              nameCl: text,
                                              verticalPadding: 5,
                                            ),
                                            if (comm?.strikerBowler != null)
                                              CustomBowlerCard(
                                                name:
                                                    "${comm?.strikerBowler?.name ?? "Player"} *",
                                                overs:
                                                    comm
                                                        ?.strikerBowler
                                                        ?.overs ??
                                                    "",
                                                maidens:
                                                    comm?.strikerBowler?.maidens
                                                        .toString() ??
                                                    "",
                                                runs:
                                                    comm?.strikerBowler?.runs
                                                        .toString() ??
                                                    "",
                                                wickets:
                                                    comm?.strikerBowler?.wickets
                                                        .toString() ??
                                                    "",
                                                eco:
                                                    comm?.strikerBowler?.eco ??
                                                    "",
                                                verticalPadding: 3,
                                              ),
                                            if (comm?.nonStrikerBowler !=
                                                null) ...[
                                              CustomBowlerCard(
                                                name:
                                                    comm
                                                        ?.nonStrikerBowler
                                                        ?.name ??
                                                    "Player",
                                                overs:
                                                    comm
                                                        ?.nonStrikerBowler
                                                        ?.overs ??
                                                    "",
                                                maidens:
                                                    comm
                                                        ?.nonStrikerBowler
                                                        ?.maidens
                                                        .toString() ??
                                                    "",
                                                runs:
                                                    comm?.nonStrikerBowler?.runs
                                                        .toString() ??
                                                    "",
                                                wickets:
                                                    comm
                                                        ?.nonStrikerBowler
                                                        ?.wickets
                                                        .toString() ??
                                                    "",
                                                eco:
                                                    comm
                                                        ?.nonStrikerBowler
                                                        ?.eco ??
                                                    "",
                                                verticalPadding: 3,
                                              ),
                                            ],
                                          ],
                                        ).paddingSymmetric(horizontal: 22.w),
                                      ),
                                      SizedBox(height: 150.h),
                                    ],
                                  ),
                                ),
                        ),
                      ).expand(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minHeight;
  final double maxHeight;

  TabBarDelegate({
    required this.child,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(TabBarDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}
