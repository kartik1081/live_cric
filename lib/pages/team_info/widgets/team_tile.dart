import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/models/crt/crt_team_model.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class TeamTile extends StatelessWidget {
  final CrtTeamModel team;
  const TeamTile({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        nb.PlaceHolderWidget(
          height: 45.h,
          width: 70.w,
        ).cornerRadiusWithClipRRect(8.r),
        SizedBox(width: 13.w),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: team.teamName,
                style: Common.textStyle(size: 18.sp, weight: FontWeight.w700),
              ),
              if (team.teamSName.isNotEmpty)
                TextSpan(
                  text: " (${team.teamSName})",
                  style: Common.textStyle(size: 14.sp, color: text),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
