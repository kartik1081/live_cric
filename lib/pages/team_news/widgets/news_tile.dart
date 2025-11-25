import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/models/crt/crt_news_model.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/widgets/custom_network_image.dart';
import 'package:nb_utils/nb_utils.dart';

class NewsTile extends StatelessWidget {
  final CrtNewsModel news;
  const NewsTile({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomNetworkImage(
          imageId: news.imageId,
          height: 75.55.h,
          width: 100.w,
          radius: 8.r,
        ),
        SizedBox(width: 13.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              news.hLine,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Common.textStyle(weight: FontWeight.w600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  news.storyType,
                  style: Common.textStyle(
                    size: 14.sp,
                    color: text,
                    weight: FontWeight.w500,
                  ),
                ),
                Text(
                  news.pubTime,
                  style: Common.textStyle(
                    size: 14.sp,
                    color: text,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ).paddingSymmetric(vertical: 3.h).expand(),
      ],
    ).withHeight(75.55.h);
  }
}
