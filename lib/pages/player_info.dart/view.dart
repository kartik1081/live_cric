import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/pages/player_info.dart/controller.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';

class PlayerInfoView extends StatelessWidget {
  const PlayerInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PlayerInfoController>(
      context,
      listen: false,
    );
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
                  "${controller.player.name} Info",
                  style: Common.textStyle(isSpl: true, size: 22.sp),
                ),
              ).expand(),
              SizedBox(width: 13.w),
            ],
          ),
          SizedBox(height: 7.h),
        ],
      ),
    );
  }
}
