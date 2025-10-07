import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/models/crt_match_model.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/widgets/custom_network_image.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class MatchTile extends StatelessWidget {
  final CrtMatchModel match;
  const MatchTile({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 7.h),
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
                    "${match.matchDesc} | ${match.seriesName}",
                    style: Common.textStyle(
                      color: soft,
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    match.date,
                    style: Common.textStyle(color: text, size: 13.sp),
                  ),
                  Text(
                    "${match.venue.ground}, ${match.venue.city}",
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
                  match.matchFormat,
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
          SizedBox(height: 7.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CustomNetworkImage(
                        imageId: match.team1.imageId,
                        width: 47.w,
                        height: 35.h,
                      ),
                      SizedBox(height: 7.h),
                      Text(
                        match.team1.teamSName,
                        style: Common.textStyle(
                          color: soft,
                          size: 14.sp,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 7.w),
                  Column(
                    children: List.generate(
                      match.team1Scores.length,
                      (index) => Row(
                        children: [
                          Text(
                            "${match.team1Scores[index].runs} / ${match.team1Scores[index].wickets}",
                            style: Common.textStyle(
                              color: soft,
                              size: 14.sp,
                              weight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "  (${match.team1Scores[index].overs})",
                            style: Common.textStyle(color: text, size: 12.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ).expand(),
              Column(
                children: [
                  Icon(Icons.circle, color: Colors.redAccent, size: 10.w),
                  Text(
                    "Live",
                    style: Common.textStyle(
                      color: Colors.redAccent,
                      size: 13.sp,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      match.team2Scores.length,
                      (index) => Row(
                        children: [
                          Text(
                            "${match.team2Scores[index].runs} / ${match.team2Scores[index].wickets}",
                            style: Common.textStyle(
                              color: soft,
                              size: 14.sp,
                              weight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "  (${match.team2Scores[index].overs})",
                            style: Common.textStyle(color: text, size: 12.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 7.w),
                  Column(
                    children: [
                      CustomNetworkImage(
                        imageId: match.team2.imageId,
                        width: 47.w,
                        height: 35.h,
                      ),
                      SizedBox(height: 7.h),
                      Text(
                        match.team2.teamSName,
                        style: Common.textStyle(
                          color: soft,
                          size: 14.sp,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ).expand(),
            ],
          ),
          SizedBox(height: 13.h),
          Divider(color: black, thickness: 1.h, height: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                match.status,
                style: Common.textStyle(color: soft, size: 14.sp),
                // overflow: TextOverflow.ellipsis,
              ).expand(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.auto_graph_rounded, color: text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
