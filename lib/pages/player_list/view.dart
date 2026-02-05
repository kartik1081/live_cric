import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/pages/player_list/controller.dart';
import 'package:live_cric/pages/player_list/widgets/player_tile.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/widgets/custom_native.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';

class PlayerListView extends StatelessWidget {
  const PlayerListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PlayerListController>(
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
                  "Team ${controller.team.countryName}'s Player",
                  style: Common.textStyle(isSpl: true, size: 22.sp),
                ),
              ).expand(),
            ],
          ),
          SizedBox(height: 7.h),
          Selector<PlayerListController, bool>(
            selector: (p0, p1) => p1.loading,
            builder: (context, loading, child) => loading
                ? Common.loader()
                : Selector<PlayerListController, List<dynamic>>(
                    selector: (p0, p1) => p1.playerList,
                    builder: (context, playerList, child) => playerList.isEmpty
                        ? Text(
                            "No Players Found.",
                            style: Common.textStyle(color: text),
                          ).center()
                        : ListView.separated(
                            itemCount: playerList.length,
                            padding: EdgeInsets.only(
                              left: 22.w,
                              right: 22.w,
                              top: 7.h,
                              bottom: 10.h,
                            ),
                            itemBuilder: (context, index) =>
                                playerList[index] == null
                                ? CustomNative(
                                    nativeType: nativeSmall,
                                    bannerType: AdSize.fullBanner,
                                    nativeId: RemoteConfigs.nativeAdRc.adId,
                                    bannerId: RemoteConfigs.bannerAdRc.adId,
                                  )
                                : PlayerTile(player: playerList[index]),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 13.h),
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
