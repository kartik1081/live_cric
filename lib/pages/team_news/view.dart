import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/pages/team_news/controller.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';

class TeamNewsView extends StatelessWidget {
  const TeamNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TeamNewsController>(context, listen: false);
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
              nb.Marquee(
                child: Text(
                  "Team ${controller.team.countryName}'s News",
                  style: Common.textStyle(isSpl: true, size: 22.sp),
                ),
              ).expand(),
            ],
          ),
          SizedBox(height: 7.h),
        ],
      ),
    );
  }
}
