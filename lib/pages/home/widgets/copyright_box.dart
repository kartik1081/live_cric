import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/routes.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class CopyrightBox extends StatelessWidget {
  const CopyrightBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Copyright", style: Common.textStyle(isSpl: true, size: 18.sp)),
        Divider(),
        Text(
          "${RemoteConfigs.appNameRc} does not stream any of the channels included in this application, all the streaming links are from third party website available freely on the internet.\n\nWe're just giving way to stream and all content is the copyright of their owner.",
          style: Common.textStyle(size: 14.sp),
        ),
        SizedBox(height: 40.h),
        Container(
          width: 275.w,
          height: 45.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: primary50,
            borderRadius: nb.radius(12.r),
          ),
          child: Text(
            "OK",
            style: Common.textStyle(
              color: black,
              weight: FontWeight.bold,
              size: 16.sp,
            ),
          ),
        ).onTap(() {
          nb.setValue(copyrightReadKey, true);
          Navigator.popUntil(
            context,
            (route) => route.settings.name == Routes.homeRt,
          );
        }),
      ],
    );
  }
}
