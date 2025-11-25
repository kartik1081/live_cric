import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/models/crt/crt_player_info_model.dart';
import 'package:live_cric/pages/player_info.dart/controller.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/widgets/custom_native.dart';
import 'package:live_cric/utils/widgets/custom_network_image.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';

class PlayerInfoView extends StatelessWidget {
  const PlayerInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PlayerInfoController>(
      context,
      listen: false,
    );
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
                  "${controller.player.name}'s Info",
                  style: Common.textStyle(isSpl: true, size: 22.sp),
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
                                    Text(
                                      playerInfo.name,
                                      style: Common.textStyle(
                                        size: 20.sp,
                                        weight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ).paddingSymmetric(horizontal: 22.w),
                              ],
                            ),
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
