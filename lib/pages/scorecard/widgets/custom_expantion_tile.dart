import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/models/crt/crt_match_scorecard_model.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class CustomExpantionTile extends StatelessWidget {
  final CrtMatchInnModel inning;
  final bool initiallyExpanded;
  const CustomExpantionTile({
    super.key,
    required this.inning,
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.h, left: 13.w, right: 13.w),
      decoration: BoxDecoration(color: popUp, borderRadius: nb.radius(12.r)),
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        iconColor: soft,
        collapsedIconColor: soft,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        textColor: soft,
        collapsedTextColor: soft,
        tilePadding: EdgeInsets.only(left: 13.w, right: 13.w),
        childrenPadding: EdgeInsets.only(bottom: 22.h),
        expandedAlignment: Alignment.centerLeft,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              inning.batTeamsName,
              style: Common.textStyle(size: 17.sp, weight: FontWeight.w700),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${inning.score} - ${inning.wickets}",
                    style: Common.textStyle(
                      size: 17.sp,
                      weight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: " (${inning.overs})",
                    style: Common.textStyle(),
                  ),
                ],
              ),
            ),
          ],
        ),
        children: [
          if (inning.batsman.isNotEmpty) ...[
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 89, 89, 90),
              ),
              child: Row(
                children: [
                  Text(
                    "Batter",
                    style: Common.textStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                  ).expand(flex: 8),
                  Text(
                    "R",
                    style: Common.textStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                  ).center().expand(flex: 1),
                  Text(
                    "B",
                    style: Common.textStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                  ).center().expand(flex: 1),
                  Text(
                    "4s",
                    style: Common.textStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                  ).center().expand(flex: 1),
                  Text(
                    "6s",
                    style: Common.textStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                  ).center().expand(flex: 1),
                  Text(
                    "SR",
                    style: Common.textStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                  ).center().expand(flex: 2),
                ],
              ).paddingSymmetric(horizontal: 13.sp, vertical: 10.h),
            ),
            ...List.generate(
              inning.batsman.length,
              (index) => Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            inning.batsman[index].name,
                            style: Common.textStyle(
                              size: 14.sp,
                              color: primary50,
                            ),
                          ),
                          if ((inning.batsman[index].outdec ?? "") != "")
                            Text(
                              inning.batsman[index].outdec!,
                              style: Common.textStyle(size: 12.sp, color: text),
                            ),
                        ],
                      ).expand(flex: 8),
                      Text(
                        inning.batsman[index].runs.toString(),
                        style: Common.textStyle(
                          size: 14.sp,
                          weight: FontWeight.w600,
                        ),
                      ).center().expand(flex: 1),
                      Text(
                        inning.batsman[index].balls.toString(),
                        style: Common.textStyle(size: 14.sp),
                      ).center().expand(flex: 1),
                      Text(
                        inning.batsman[index].fours.toString(),
                        style: Common.textStyle(size: 14.sp),
                      ).center().expand(flex: 1),
                      Text(
                        inning.batsman[index].six.toString(),
                        style: Common.textStyle(size: 14.sp),
                      ).center().expand(flex: 1),
                      Text(
                        inning.batsman[index].strkrate.toString(),
                        style: Common.textStyle(size: 14.sp),
                      ).center().expand(flex: 2),
                    ],
                  ).paddingSymmetric(horizontal: 13.sp, vertical: 13.h),
                  Divider(color: text, thickness: 0.5, height: 0),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Extras",
                  style: Common.textStyle(size: 14.sp, color: soft),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: inning.extras.total.toString(),
                        style: Common.textStyle(size: 14.sp, color: soft),
                      ),
                      TextSpan(
                        text:
                            " (b ${inning.extras.byes}, lb ${inning.extras.legbyes}, w ${inning.extras.wides}, nb ${inning.extras.noballs}, p ${inning.extras.penalty})",
                        style: Common.textStyle(size: 14.sp, color: text),
                      ),
                    ],
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 13.sp, vertical: 10.h),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(55, 250, 209, 28),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total", style: Common.textStyle(size: 14.sp)),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${inning.score} - ${inning.wickets}",
                          style: Common.textStyle(size: 14.sp, color: soft),
                        ),
                        TextSpan(
                          text:
                              " (${inning.overs} Overs, RR: ${inning.runrate})",
                          style: Common.textStyle(size: 14.sp, color: text),
                        ),
                      ],
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 13.sp, vertical: 10.h),
            ),
          ],
          if (inning.batsman.isNotEmpty) ...[
            SizedBox(height: 13.h),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 89, 89, 90),
              ),
              child: Row(
                children: [
                  Text(
                    "Bowler",
                    style: Common.textStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                  ).expand(flex: 9),
                  Text(
                    "O",
                    style: Common.textStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                  ).center().expand(flex: 1),
                  Text(
                    "M",
                    style: Common.textStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                  ).center().expand(flex: 1),
                  Text(
                    "R",
                    style: Common.textStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                  ).center().expand(flex: 1),
                  Text(
                    "W",
                    style: Common.textStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                  ).center().expand(flex: 1),
                  Text(
                    "ECO",
                    style: Common.textStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                  ).center().expand(flex: 2),
                ],
              ).paddingSymmetric(horizontal: 13.sp, vertical: 10.h),
            ),
            ...List.generate(
              inning.bowlers.length,
              (index) => Column(
                children: [
                  Row(
                    children: [
                      Text(
                        inning.bowlers[index].nickname,
                        style: Common.textStyle(size: 14.sp, color: primary50),
                      ).expand(flex: 9),
                      Text(
                        inning.bowlers[index].overs,
                        style: Common.textStyle(
                          size: 14.sp,
                          weight: FontWeight.w600,
                        ),
                      ).center().expand(flex: 1),
                      Text(
                        inning.bowlers[index].maidens.toString(),
                        style: Common.textStyle(size: 14.sp),
                      ).center().expand(flex: 1),
                      Text(
                        inning.bowlers[index].runs.toString(),
                        style: Common.textStyle(size: 14.sp),
                      ).center().expand(flex: 1),
                      Text(
                        inning.bowlers[index].wickets.toString(),
                        style: Common.textStyle(size: 14.sp),
                      ).center().expand(flex: 1),
                      Text(
                        inning.bowlers[index].economy,
                        style: Common.textStyle(size: 14.sp),
                      ).center().expand(flex: 2),
                    ],
                  ).paddingSymmetric(horizontal: 13.sp, vertical: 13.h),
                  Divider(color: text, thickness: 0.5, height: 0),
                ],
              ),
            ),
          ],
          if (inning.fow.isNotEmpty) ...[
            SizedBox(height: 13.h),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 89, 89, 90),
              ),
              child: Row(
                children: [
                  Text(
                    "Faal of Wickets",
                    style: Common.textStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                  ).expand(flex: 7),
                  Text(
                    "Score",
                    style: Common.textStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                  ).center().expand(flex: 2),
                  Text(
                    "Over",
                    style: Common.textStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                  ).center().expand(flex: 2),
                ],
              ).paddingSymmetric(horizontal: 13.sp, vertical: 10.h),
            ),
            ...List.generate(
              inning.fow.length,
              (index) => Column(
                children: [
                  Row(
                    children: [
                      Text(
                        inning.fow[index].batsmanName,
                        style: Common.textStyle(size: 14.sp, color: primary50),
                      ).expand(flex: 7),
                      Text(
                        "${inning.fow[index].runs}-${index + 1}",
                        style: Common.textStyle(
                          size: 14.sp,
                          weight: FontWeight.w600,
                        ),
                      ).center().expand(flex: 2),
                      Text(
                        inning.fow[index].overnbr.toString(),
                        style: Common.textStyle(size: 14.sp),
                      ).center().expand(flex: 2),
                    ],
                  ).paddingSymmetric(horizontal: 13.sp, vertical: 13.h),
                  Divider(color: text, thickness: 0.5, height: 0),
                ],
              ),
            ),
          ],
          if (inning.pp.isNotEmpty) ...[
            SizedBox(height: 13.h),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 89, 89, 90),
              ),
              child: Row(
                children: [
                  Text(
                    "Powerplays",
                    style: Common.textStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                  ).expand(flex: 7),
                  Text(
                    "Overs",
                    style: Common.textStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                  ).center().expand(flex: 3),
                  Text(
                    "Score",
                    style: Common.textStyle(
                      size: 14.sp,
                      weight: FontWeight.w600,
                    ),
                  ).center().expand(flex: 3),
                ],
              ).paddingSymmetric(horizontal: 13.sp, vertical: 10.h),
            ),
            ...List.generate(
              inning.pp.length,
              (index) => Column(
                children: [
                  Row(
                    children: [
                      Text(
                        inning.pp[index].ppType,
                        style: Common.textStyle(size: 14.sp, color: primary50),
                      ).expand(flex: 7),
                      Text(
                        "${inning.pp[index].overFrom} - ${inning.pp[index].overTo}",
                        style: Common.textStyle(
                          size: 14.sp,
                          weight: FontWeight.w600,
                        ),
                      ).center().expand(flex: 3),
                      Text(
                        "${inning.pp[index].runs} - ${inning.pp[index].wickets}",
                        style: Common.textStyle(size: 14.sp),
                      ).center().expand(flex: 3),
                    ],
                  ).paddingSymmetric(horizontal: 13.sp, vertical: 13.h),
                  Divider(color: text, thickness: 0.5, height: 0),
                ],
              ),
            ),
          ],
          if (inning.ps.isNotEmpty) ...[
            SizedBox(height: 13.h),
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 89, 89, 90),
              ),
              child: Text(
                "Partnerships",
                style: Common.textStyle(size: 14.sp, weight: FontWeight.w600),
              ).paddingSymmetric(horizontal: 13.sp, vertical: 10.h),
            ),
            ...List.generate(
              inning.ps.length,
              (index) => Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            inning.ps[index].bat1Name,
                            style: Common.textStyle(
                              size: 14.sp,
                              color: primary50,
                            ),
                          ),
                          Text(
                            "${inning.ps[index].bat1Runs} (${inning.ps[index].bat1Balls})",
                            style: Common.textStyle(size: 14.sp, color: text),
                          ),
                        ],
                      ).expand(flex: 5),
                      Text(
                        "${inning.ps[index].totalRuns} (${inning.ps[index].totalBalls})",
                        style: Common.textStyle(size: 14.sp),
                      ).center().expand(flex: 2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            inning.ps[index].bat2Name,
                            style: Common.textStyle(
                              size: 14.sp,
                              color: primary50,
                            ),
                          ),
                          Text(
                            "${inning.ps[index].bat2Runs} (${inning.ps[index].bat2Balls})",
                            style: Common.textStyle(size: 14.sp, color: text),
                          ),
                        ],
                      ).expand(flex: 5),
                    ],
                  ).paddingSymmetric(horizontal: 13.sp, vertical: 13.h),
                  Divider(color: text, thickness: 0.5, height: 0),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
