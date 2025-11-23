import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/models/crt/crt_team_schedule_model.dart';
import 'package:live_cric/pages/team_info/widgets/scheduled_match_tile.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';

class ScheduleTile extends StatelessWidget {
  final CrtTeamScheduleModel schedule;
  const ScheduleTile({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Divider(color: text, thickness: 0.5).expand(),
            Text(
              schedule.key,
              style: Common.textStyle(size: 14.sp),
            ).paddingSymmetric(horizontal: 13.w),
            Divider(color: text, thickness: 0.5).expand(),
          ],
        ),
        ListView.separated(
          itemCount: schedule.match.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(left: 13.w, right: 13.w, top: 7.h),
          itemBuilder: (context, index) =>
              ScheduledMatchTile(scheduledMatch: schedule.match[index]),
          separatorBuilder: (context, index) => const SizedBox(),
        ),
      ],
    );
  }
}
