import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/models/crt/crt_match_model.dart';
import 'package:live_cric/pages/home/controller.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/routes.dart';
import 'package:live_cric/utils/widgets/custom_network_image.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';

class MatchTile extends StatefulWidget {
  CrtMatchModel match;
  MatchTile({super.key, required this.match});

  @override
  State<MatchTile> createState() => _MatchTileState();
}

class _MatchTileState extends State<MatchTile> {
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
                    "${widget.match.matchId} · ${widget.match.matchDesc} | ${widget.match.seriesName}",
                    maxLines: 1,
                    style: Common.textStyle(
                      color: soft,
                      size: 12.sp,
                      weight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.match.date,
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
                  widget.match.matchFormat,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CustomNetworkImage(
                        imageId: widget.match.team1.imageId,
                        width: 47.w,
                        height: 35.h,
                      ),
                      SizedBox(height: 7.h),
                      Text(
                        widget.match.team1.teamSName,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: Common.textStyle(
                          color: soft,
                          size: 14.sp,
                          isSpl: true,
                        ),
                      ).center().withWidth(47.w),
                    ],
                  ),
                  SizedBox(width: 7.w),
                  if (widget.match.team1Scores.isEmpty)
                    Text(
                      "Yet to Bat",
                      style: Common.textStyle(
                        color: soft,
                        size: 14.sp,
                        weight: FontWeight.w700,
                      ),
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        widget.match.team1Scores.length,
                        (index) => Row(
                          children: [
                            Text(
                              "${widget.match.team1Scores[index].runs}/${widget.match.team1Scores[index].wickets}",
                              style: Common.textStyle(
                                color: soft,
                                size: 15.sp,
                                isSpl: true,
                              ),
                            ),
                            Text(
                              " (${widget.match.team1Scores[index].overs})",
                              style: Common.textStyle(color: text, size: 11.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ).expand(),
              if (widget.match.state == inProgressSt ||
                  widget.match.state == tossSt)
                Column(
                  children: [
                    Icon(Icons.circle, color: Colors.greenAccent, size: 8.w),
                    Text(
                      "Live",
                      style: Common.textStyle(
                        color: Colors.greenAccent,
                        size: 11.sp,
                      ),
                    ),
                  ],
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (widget.match.team2Scores.isEmpty)
                    Text(
                      "Yet to Bat",
                      style: Common.textStyle(
                        color: soft,
                        size: 14.sp,
                        weight: FontWeight.w700,
                      ),
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(
                        widget.match.team2Scores.length,
                        (index) => Row(
                          children: [
                            Text(
                              "${widget.match.team2Scores[index].runs}/${widget.match.team2Scores[index].wickets}",
                              style: Common.textStyle(
                                color: soft,
                                size: 15.sp,
                                isSpl: true,
                              ),
                            ),
                            Text(
                              " (${widget.match.team2Scores[index].overs})",
                              style: Common.textStyle(color: text, size: 11.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(width: 7.w),
                  Column(
                    children: [
                      CustomNetworkImage(
                        imageId: widget.match.team2.imageId,
                        width: 47.w,
                        height: 35.h,
                      ),
                      SizedBox(height: 7.h),
                      Text(
                        widget.match.team2.teamSName,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: Common.textStyle(
                          color: soft,
                          size: 14.sp,
                          isSpl: true,
                        ),
                      ).center().withWidth(47.w),
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
                widget.match.status,
                style: Common.textStyle(color: primary50, size: 14.sp),
                // overflow: TextOverflow.ellipsis,
              ).expand(),
              IconButton(
                onPressed: () async {
                  final result = await Navigator.pushNamed(
                    context,
                    Routes.scorecardRt,
                    arguments: {matchKey: widget.match},
                  );
                  if (result != null && result is Map) {
                    setState(() {
                      widget.match = (result[matchKey] as CrtMatchModel);
                    });
                  }
                },
                icon: const Icon(Icons.auto_graph_rounded, color: text),
              ),
            ],
          ),
        ],
      ),
    ).onTap(() async {
      if (widget.match.state == tossSt) {
        Common.showSnackbar(context, "Match is not started yet!");
        return;
      }
      Provider.of<HomeController>(
        context,
        listen: false,
      ).getStreamingLink(context, match: widget.match);
    });
  }
}
