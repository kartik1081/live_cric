import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/models/crt/crt_team_player_model.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/routes.dart';
import 'package:live_cric/utils/widgets/custom_network_image.dart';
import 'package:nb_utils/nb_utils.dart';

class PlayerTile extends StatelessWidget {
  final CrtTeamPlayerModel player;
  const PlayerTile({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomNetworkImage(
          imageId: player.imageId,
          height: 50.h,
          width: 67.w,
          radius: 8.r,
        ),
        SizedBox(width: 13.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              player.name,
              style: Common.textStyle(size: 18.sp, weight: FontWeight.w700),
            ),
            if (player.battingStyle.isNotEmpty ||
                player.bowlingStyle.isNotEmpty)
              SizedBox(height: 3.h),
            Text(
              "${player.battingStyle}${player.battingStyle.isNotEmpty && player.bowlingStyle.isNotEmpty ? " / " : ""}${player.bowlingStyle}",
              style: Common.textStyle(
                size: 12.sp,
                color: text,
                weight: FontWeight.w700,
              ),
            ),
          ],
        ).expand(),
        Icon(Icons.arrow_forward_ios_rounded, color: soft, size: 15.w),
      ],
    ).onTap(
      () => Navigator.pushNamed(
        context,
        Routes.playerInfoRt,
        arguments: {playerIdKey: player.id},
      ),
    );
  }
}
