import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/routes.dart';
import 'package:nb_utils/nb_utils.dart';

class TeamInfoView extends StatelessWidget {
  const TeamInfoView({super.key});

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
                "Team Info",
                style: Common.textStyle(isSpl: true, size: 22.sp),
              ),
            ],
          ),
          SizedBox(height: 7.h),
          Row(
            children: [
              Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Schedules",
                      style: Common.textStyle(
                        color: soft,
                        size: 16.sp,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Divider(height: 0, color: soft, thickness: 2).withWidth(60.w),
                ],
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.playerListRt),
                child: Text(
                  "Players",
                  style: Common.textStyle(
                    color: text,
                    size: 16.sp,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => null,
                child: Text(
                  "News",
                  style: Common.textStyle(
                    color: text,
                    size: 16.sp,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 18.w),
          Divider(color: text, thickness: 0.2, height: 0),
        ],
      ),
    );
  }
}
