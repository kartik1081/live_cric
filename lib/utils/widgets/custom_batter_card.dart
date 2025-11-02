import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomBatterCard extends StatelessWidget {
  final String name;
  final String runs;
  final String balls;
  final String fours;
  final String sixes;
  final String sr;
  final Color nameCl;
  final int verticalPadding;

  const CustomBatterCard({
    super.key,
    required this.name,
    required this.runs,
    required this.balls,
    required this.fours,
    required this.sixes,
    required this.sr,
    this.nameCl = primary50,
    this.verticalPadding = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name,
          style: Common.textStyle(
            color: nameCl,
            size: 14.sp,
            weight: FontWeight.w600,
          ),
        ).expand(flex: 10),
        Text(
          runs,
          style: Common.textStyle(
            color: soft,
            size: 14.sp,
            weight: FontWeight.w600,
          ),
        ).center().expand(flex: 2),
        Text(
          balls,
          style: Common.textStyle(
            color: text,
            size: 14.sp,
            weight: FontWeight.w400,
          ),
        ).center().expand(flex: 2),
        Text(
          fours,
          style: Common.textStyle(
            color: text,
            size: 14.sp,
            weight: FontWeight.w400,
          ),
        ).center().expand(flex: 2),
        Text(
          sixes,
          style: Common.textStyle(
            color: text,
            size: 14.sp,
            weight: FontWeight.w400,
          ),
        ).center().expand(flex: 2),
        Text(
          sr,
          style: Common.textStyle(
            color: text,
            size: 14.sp,
            weight: FontWeight.w400,
          ),
        ).center().expand(flex: 3),
      ],
    ).paddingSymmetric(vertical: verticalPadding.h);
  }
}
