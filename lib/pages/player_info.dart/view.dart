import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/models/crt/crt_player_info_model.dart';
import 'package:live_cric/pages/player_info.dart/controller.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/widgets/custom_native.dart';
import 'package:live_cric/utils/widgets/custom_network_image.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';

class PlayerInfoView extends StatelessWidget {
  const PlayerInfoView({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: Selector<PlayerInfoController, CrtPlayerInfoModel?>(
                  selector: (p0, p1) => p1.playerInfo,
                  builder: (context, playerInfo, child) => Text(
                    "${playerInfo?.name ?? "Player"}'s Info",
                    style: Common.textStyle(isSpl: true, size: 22.sp),
                  ),
                ),
              ).expand(),
              SizedBox(width: 13.w),
            ],
          ),
          SizedBox(height: 7.h),
          Selector<PlayerInfoController, bool>(
            selector: (p0, p1) => p1.loading,
            builder: (context, loading, child) => loading
                ? Common.loader()
                : Selector<PlayerInfoController, CrtPlayerInfoModel?>(
                    selector: (p0, p1) => p1.playerInfo,
                    builder: (context, playerInfo, child) => playerInfo == null
                        ? Text(
                            "No Player Found.",
                            style: Common.textStyle(color: text),
                          ).center()
                        : SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CustomNetworkImage(
                                      imageId: playerInfo.faceImageId,
                                      height: 52.18.h,
                                      width: 70.w,
                                      radius: 4.r,
                                    ),
                                    SizedBox(width: 13.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          playerInfo.name,
                                          style: Common.textStyle(
                                            size: 20.sp,
                                            weight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 3.h),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 7.w,
                                            vertical: 2.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: popUp,
                                            borderRadius: nb.radius(6.r),
                                          ),
                                          child: Row(
                                            children: [
                                              CustomNetworkImage(
                                                imageId:
                                                    playerInfo.intlTeamImageId,
                                                height: 12.h,
                                                width: 16.w,
                                                radius: 2.r,
                                              ),
                                              SizedBox(width: 3.w),
                                              Text(
                                                playerInfo.intlTeam,
                                                style: Common.textStyle(
                                                  color: soft,
                                                  size: 12.sp,
                                                  weight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ).paddingSymmetric(horizontal: 22.w),
                                SizedBox(height: 24.h),
                                Text(
                                  "Personal Information",
                                  style: Common.textStyle(
                                    weight: FontWeight.w600,
                                  ),
                                ).paddingSymmetric(horizontal: 22.w),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 13.h),
                                  margin: EdgeInsets.only(
                                    top: 7.h,
                                    left: 13.w,
                                    right: 13.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: popUp,
                                    borderRadius: nb.radius(8.r),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Born",
                                            style: Common.textStyle(
                                              color: text,
                                              size: 13.sp,
                                            ),
                                          ).expand(flex: 3),
                                          Text(
                                            playerInfo.dob,
                                            style: Common.textStyle(
                                              color: soft,
                                              size: 13.sp,
                                              weight: FontWeight.w600,
                                            ),
                                          ).expand(flex: 7),
                                        ],
                                      ).paddingSymmetric(horizontal: 25.w),
                                      Divider(color: text, thickness: 0.5),
                                      Row(
                                        children: [
                                          Text(
                                            "Birth Place",
                                            style: Common.textStyle(
                                              color: text,
                                              size: 13.sp,
                                            ),
                                          ).expand(flex: 3),
                                          Text(
                                            playerInfo.birthPlace,
                                            style: Common.textStyle(
                                              color: soft,
                                              size: 13.sp,
                                              weight: FontWeight.w600,
                                            ),
                                          ).expand(flex: 7),
                                        ],
                                      ).paddingSymmetric(horizontal: 25.w),
                                      Divider(color: text, thickness: 0.5),
                                      Row(
                                        children: [
                                          Text(
                                            "Nickname",
                                            style: Common.textStyle(
                                              color: text,
                                              size: 13.sp,
                                            ),
                                          ).expand(flex: 3),
                                          Text(
                                            playerInfo.nickName,
                                            style: Common.textStyle(
                                              color: soft,
                                              size: 13.sp,
                                              weight: FontWeight.w600,
                                            ),
                                          ).expand(flex: 7),
                                        ],
                                      ).paddingSymmetric(horizontal: 25.w),
                                      Divider(color: text, thickness: 0.5),
                                      Row(
                                        children: [
                                          Text(
                                            "Role",
                                            style: Common.textStyle(
                                              color: text,
                                              size: 13.sp,
                                            ),
                                          ).expand(flex: 3),
                                          Text(
                                            playerInfo.role,
                                            style: Common.textStyle(
                                              color: soft,
                                              size: 13.sp,
                                              weight: FontWeight.w600,
                                            ),
                                          ).expand(flex: 7),
                                        ],
                                      ).paddingSymmetric(horizontal: 25.w),
                                      Divider(color: text, thickness: 0.5),
                                      Row(
                                        children: [
                                          Text(
                                            "Batting Style",
                                            style: Common.textStyle(
                                              color: text,
                                              size: 13.sp,
                                            ),
                                          ).expand(flex: 3),
                                          Text(
                                            playerInfo.bat,
                                            style: Common.textStyle(
                                              color: soft,
                                              size: 13.sp,
                                              weight: FontWeight.w600,
                                            ),
                                          ).expand(flex: 7),
                                        ],
                                      ).paddingSymmetric(horizontal: 25.w),
                                      Divider(color: text, thickness: 0.5),
                                      Row(
                                        children: [
                                          Text(
                                            "Bowling Style",
                                            style: Common.textStyle(
                                              color: text,
                                              size: 13.sp,
                                            ),
                                          ).expand(flex: 3),
                                          Text(
                                            playerInfo.bowl,
                                            style: Common.textStyle(
                                              color: soft,
                                              size: 13.sp,
                                              weight: FontWeight.w600,
                                            ),
                                          ).expand(flex: 7),
                                        ],
                                      ).paddingSymmetric(horizontal: 25.w),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                CustomNative(
                                  nativeType: nativeSmall,
                                  bannerType: AdSize.fullBanner,
                                  nativeId: RemoteConfigs.nativeAdRc.adId,
                                  bannerId: RemoteConfigs.bannerAdRc.adId,
                                  bottomPadding: 16,
                                ),
                                Text(
                                  "Teams",
                                  style: Common.textStyle(
                                    weight: FontWeight.w600,
                                  ),
                                ).paddingSymmetric(horizontal: 22.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 7.h,
                                    horizontal: 13.w,
                                  ),
                                  margin: EdgeInsets.only(
                                    top: 7.h,
                                    left: 13.w,
                                    right: 13.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: popUp,
                                    borderRadius: nb.radius(8.r),
                                  ),
                                  child: Text(
                                    playerInfo.teams,
                                    style: Common.textStyle(
                                      color: text,
                                      size: 13.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                CustomNative(
                                  nativeType: nativeSmall,
                                  bannerType: AdSize.fullBanner,
                                  nativeId: RemoteConfigs.nativeAdRc.adId,
                                  bannerId: RemoteConfigs.bannerAdRc.adId,
                                  bottomPadding: 16,
                                ),
                                Text(
                                  "Recent Form",
                                  style: Common.textStyle(
                                    weight: FontWeight.w600,
                                  ),
                                ).paddingSymmetric(horizontal: 22.w),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 7.h),
                                  margin: EdgeInsets.only(
                                    top: 7.h,
                                    left: 13.w,
                                    right: 13.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: popUp,
                                    borderRadius: nb.radius(8.r),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Batting",
                                        style: Common.textStyle(
                                          color: text,
                                          size: 14.sp,
                                        ),
                                      ).paddingSymmetric(horizontal: 13.w),
                                      SizedBox(height: 7.h),
                                      Container(
                                        color: text.withValues(alpha: 0.1),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 13.w,
                                          vertical: 10.h,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              "OPPN.",
                                              style: Common.textStyle(
                                                color: text,
                                                size: 12.sp,
                                              ),
                                            ).expand(flex: 8),
                                            Text(
                                              "SCORE",
                                              style: Common.textStyle(
                                                color: text,
                                                size: 12.sp,
                                              ),
                                            ).center().expand(flex: 5),
                                            Text(
                                              "FORMAT",
                                              style: Common.textStyle(
                                                color: text,
                                                size: 12.sp,
                                              ),
                                            ).center().expand(flex: 5),
                                            Text(
                                              "DATE",
                                              style: Common.textStyle(
                                                color: text,
                                                size: 12.sp,
                                              ),
                                            ).center().expand(flex: 5),
                                          ],
                                        ),
                                      ),
                                      ...List.generate(
                                        playerInfo.recentBatting.length,
                                        (index) => Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  playerInfo
                                                      .recentBatting[index][0],
                                                  style: Common.textStyle(
                                                    color: text,
                                                    size: 12.sp,
                                                  ),
                                                ).expand(flex: 8),
                                                Text(
                                                  playerInfo
                                                      .recentBatting[index][1],
                                                  style: Common.textStyle(
                                                    color: text,
                                                    size: 12.sp,
                                                  ),
                                                ).center().expand(flex: 5),
                                                Text(
                                                  playerInfo
                                                      .recentBatting[index][2],
                                                  style: Common.textStyle(
                                                    color: text,
                                                    size: 12.sp,
                                                  ),
                                                ).center().expand(flex: 5),
                                                Text(
                                                  playerInfo
                                                      .recentBatting[index][3],
                                                  style: Common.textStyle(
                                                    color: text,
                                                    size: 12.sp,
                                                  ),
                                                ).center().expand(flex: 5),
                                              ],
                                            ).paddingSymmetric(
                                              horizontal: 13.w,
                                              vertical: 10.h,
                                            ),
                                            if (index !=
                                                playerInfo
                                                        .recentBatting
                                                        .length -
                                                    1)
                                              Divider(
                                                color: text,
                                                thickness: 0.3,
                                                height: 0,
                                              ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                      Text(
                                        "Batting",
                                        style: Common.textStyle(
                                          color: text,
                                          size: 14.sp,
                                        ),
                                      ).paddingSymmetric(horizontal: 13.w),
                                      SizedBox(height: 7.h),
                                      Container(
                                        color: text.withValues(alpha: 0.1),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 13.w,
                                          vertical: 10.h,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              "OPPN.",
                                              style: Common.textStyle(
                                                color: text,
                                                size: 12.sp,
                                              ),
                                            ).expand(flex: 8),
                                            Text(
                                              "WICKETS",
                                              style: Common.textStyle(
                                                color: text,
                                                size: 12.sp,
                                              ),
                                            ).center().expand(flex: 5),
                                            Text(
                                              "FORMAT",
                                              style: Common.textStyle(
                                                color: text,
                                                size: 12.sp,
                                              ),
                                            ).center().expand(flex: 5),
                                            Text(
                                              "DATE",
                                              style: Common.textStyle(
                                                color: text,
                                                size: 12.sp,
                                              ),
                                            ).center().expand(flex: 5),
                                          ],
                                        ),
                                      ),
                                      ...List.generate(
                                        playerInfo.recentBowling.length,
                                        (index) => Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  playerInfo
                                                      .recentBowling[index][0],
                                                  style: Common.textStyle(
                                                    color: text,
                                                    size: 12.sp,
                                                  ),
                                                ).expand(flex: 8),
                                                Text(
                                                  playerInfo
                                                      .recentBowling[index][1],
                                                  style: Common.textStyle(
                                                    color: text,
                                                    size: 12.sp,
                                                  ),
                                                ).center().expand(flex: 5),
                                                Text(
                                                  playerInfo
                                                      .recentBowling[index][2],
                                                  style: Common.textStyle(
                                                    color: text,
                                                    size: 12.sp,
                                                  ),
                                                ).center().expand(flex: 5),
                                                Text(
                                                  playerInfo
                                                      .recentBowling[index][3],
                                                  style: Common.textStyle(
                                                    color: text,
                                                    size: 12.sp,
                                                  ),
                                                ).center().expand(flex: 5),
                                              ],
                                            ).paddingSymmetric(
                                              horizontal: 13.w,
                                              vertical: 10.h,
                                            ),
                                            if (index !=
                                                playerInfo
                                                        .recentBowling
                                                        .length -
                                                    1)
                                              Divider(
                                                color: text,
                                                thickness: 0.3,
                                                height: 0,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                CustomNative(
                                  nativeType: nativeSmall,
                                  bannerType: AdSize.fullBanner,
                                  nativeId: RemoteConfigs.nativeAdRc.adId,
                                  bannerId: RemoteConfigs.bannerAdRc.adId,
                                  bottomPadding: 16,
                                ),
                                Text(
                                  "Bio",
                                  style: Common.textStyle(
                                    weight: FontWeight.w600,
                                  ),
                                ).paddingSymmetric(horizontal: 22.w),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 7.h,
                                    left: 13.w,
                                    right: 13.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: popUp,
                                    borderRadius: nb.radius(8.r),
                                  ),
                                  child:
                                      // Text(
                                      //   playerInfo.bio,
                                      //   style: Common.textStyle(color: text),
                                      // ),
                                      Html(
                                        data: playerInfo.bio,
                                        style: {
                                          "body": Style(
                                            color: text, // Text color
                                            fontSize: FontSize(
                                              13.sp,
                                            ), // Text size
                                          ),
                                        },
                                      ),
                                ),
                                CustomNative(
                                  nativeType: nativeMedium,
                                  bannerType: AdSize.mediumRectangle,
                                  nativeId: RemoteConfigs.nativeAdRc.adId,
                                  bannerId: RemoteConfigs.bannerAdRc.adId,
                                ),
                                SizedBox(height: 150.h),
                              ],
                            ),
                          ),
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
