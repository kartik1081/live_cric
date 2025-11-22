import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/models/crt/crt_team_model.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/pages/team_list/controller.dart';
import 'package:live_cric/pages/team_list/widgets/team_tile.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/widgets/custom_native.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';

class TeamListView extends StatelessWidget {
  const TeamListView({super.key});

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
              Text(
                "Team Info",
                style: Common.textStyle(isSpl: true, size: 22.sp),
              ),
            ],
          ),
          SizedBox(height: 13.h),
          Selector<TeamListController, bool>(
            selector: (p0, p1) => p1.loading,
            builder: (context, loading, child) => loading
                ? Common.loader()
                : Selector<TeamListController, List<CrtTeamModel>>(
                    selector: (p0, p1) => p1.teamList,
                    builder: (context, teamList, child) => ListView.separated(
                      itemCount: teamList.length,
                      padding: EdgeInsets.only(
                        left: 22.w,
                        right: 22.w,
                        top: 7.h,
                        bottom: 120.h,
                      ),
                      itemBuilder: (context, index) =>
                          TeamTile(team: teamList[index]),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 13.h),
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
