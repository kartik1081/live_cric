import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/models/crt/crt_team_player_model.dart';
import 'package:live_cric/pages/player_list/controller.dart';
import 'package:live_cric/pages/player_list/widgets/player_tile.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class PlayerListView extends StatelessWidget {
  const PlayerListView({super.key});

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
                "Player List",
                style: Common.textStyle(isSpl: true, size: 22.sp),
              ),
            ],
          ),
          SizedBox(height: 7.h),
          Selector<PlayerListController, bool>(
            selector: (p0, p1) => p1.loading,
            builder: (context, loading, child) => loading
                ? Common.loader()
                : Selector<PlayerListController, List<CrtTeamPlayerModel>>(
                    selector: (p0, p1) => p1.playerList,
                    builder: (context, playerList, child) => ListView.separated(
                      itemCount: playerList.length,
                      padding: EdgeInsets.only(
                        left: 22.w,
                        right: 22.w,
                        top: 7.h,
                        bottom: 120.h,
                      ),
                      itemBuilder: (context, index) =>
                          PlayerTile(player: playerList[index]),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 13.h),
                    ),
                  ),
          ).expand(),
        ],
      ),
    );
  }
}
