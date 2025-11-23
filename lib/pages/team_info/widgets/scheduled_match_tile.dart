import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/models/crt/crt_schedule_match_model.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/flaove_config.dart';
import 'package:live_cric/utils/widgets/custom_network_image.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class ScheduledMatchTile extends StatelessWidget {
  final CrtScheduleMatchModel scheduledMatch;

  const ScheduledMatchTile({super.key, required this.scheduledMatch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(13.w),
      decoration: BoxDecoration(color: popUp, borderRadius: nb.radius(12.r)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${FlavorConfig.flavor == FlavorEnum.dev ? "${scheduledMatch.matchInfo.matchId} · " : ""}${scheduledMatch.matchInfo.seriesName}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Common.textStyle(
                      color: soft,
                      size: 12.sp,
                      weight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${scheduledMatch.matchInfo.venue.ground}, ${scheduledMatch.matchInfo.venue.city}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Common.textStyle(color: text, size: 13.sp),
                  ),
                  Text(
                    "${scheduledMatch.matchInfo.startDate} - ${scheduledMatch.matchInfo.endDate}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Common.textStyle(color: text, size: 13.sp),
                  ),
                ],
              ).expand(),
              SizedBox(width: 7.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: primary50,
                  borderRadius: nb.radius(4.r),
                ),
                child: Text(
                  scheduledMatch.matchInfo.matchFormat,
                  style: Common.textStyle(
                    color: black,
                    size: 13.sp,
                    weight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Divider(color: black, thickness: 1.h),
          Row(
            children: [
              CustomNetworkImage(
                imageId: scheduledMatch.matchInfo.team1.imageId,
                height: 45.h,
                width: 59.w,
                radius: 8.r,
              ),
              SizedBox(width: 7.w),
              Text(
                scheduledMatch.matchInfo.team1.teamSname,
                style: Common.textStyle(isSpl: true),
              ),
              const Spacer(),
              Text(
                scheduledMatch.matchInfo.team2.teamSname,
                style: Common.textStyle(isSpl: true),
              ),
              SizedBox(width: 7.w),
              CustomNetworkImage(
                imageId: scheduledMatch.matchInfo.team2.imageId,
                height: 45.h,
                width: 59.w,
                radius: 8.r,
              ),
            ],
          ),
          SizedBox(height: 13.h),
          Container(
            decoration: BoxDecoration(
              color: primary50,
              borderRadius: nb.radius(4.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            child: Text(
              scheduledMatch.matchInfo.state,
              style: Common.textStyle(
                size: 14.sp,
                color: black,
                weight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
