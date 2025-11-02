import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomBowlerCard extends StatelessWidget {
  final String name;
  final String overs;
  final String maidens;
  final String runs;
  final String wickets;
  final String eco;
  final Color nameCl;
  final int verticalPadding;

  const CustomBowlerCard({
    super.key,
    required this.name,
    required this.overs,
    required this.maidens,
    required this.runs,
    required this.wickets,
    required this.eco,
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
            size: 14.sp,
            color: nameCl,
            weight: FontWeight.w600,
          ),
        ).expand(flex: 10),
        Text(
          overs,
          style: Common.textStyle(
            size: 14.sp,
            color: text,
            weight: FontWeight.w400,
          ),
        ).center().expand(flex: 2),
        Text(
          maidens,
          style: Common.textStyle(
            size: 14.sp,
            color: text,
            weight: FontWeight.w400,
          ),
        ).center().expand(flex: 2),
        Text(
          runs,
          style: Common.textStyle(
            size: 14.sp,
            color: text,
            weight: FontWeight.w400,
          ),
        ).center().expand(flex: 2),
        Text(
          wickets,
          style: Common.textStyle(
            size: 14.sp,
            color: soft,
            weight: FontWeight.w600,
          ),
        ).center().expand(flex: 2),
        Text(
          eco,
          style: Common.textStyle(
            size: 14.sp,
            color: text,
            weight: FontWeight.w400,
          ),
        ).center().expand(flex: 3),
      ],
    ).paddingSymmetric(vertical: verticalPadding.h);
  }
}
