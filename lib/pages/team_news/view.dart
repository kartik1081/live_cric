import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/pages/team_news/controller.dart';
import 'package:live_cric/pages/team_news/widgets/news_tile.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/widgets/custom_native.dart';
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
          Selector<TeamNewsController, bool>(
            selector: (p0, p1) => p1.loading,
            builder: (context, loading, child) => loading
                ? Common.loader()
                : Selector<TeamNewsController, List<dynamic>>(
                    selector: (p0, p1) => p1.teamNews,
                    builder: (context, teamNews, child) => teamNews.isEmpty
                        ? Text(
                            "No News Found.",
                            style: Common.textStyle(color: text),
                          ).center()
                        : ListView.separated(
                            itemCount: teamNews.length,
                            padding: EdgeInsets.only(
                              left: 22.w,
                              right: 22.w,
                              top: 7.h,
                              bottom: 150.h,
                            ),
                            itemBuilder: (context, index) =>
                                teamNews[index] == null
                                ? CustomNative(
                                    nativeType: nativeSmall,
                                    bannerType: AdSize.fullBanner,
                                    nativeId: RemoteConfigs.nativeIdRc,
                                    bannerId: RemoteConfigs.bannerIdRc,
                                  )
                                : NewsTile(news: teamNews[index]),
                            separatorBuilder: (context, index) =>
                                Divider(color: text, thickness: 0.5),
                          ),
                  ),
          ).expand(),
          // CustomNative(
          //   nativeType: "",
          //   bannerType: AdSize.fullBanner,
          //   nativeId: "",
          //   bannerId: RemoteConfigs.bannerIdRc,
          // ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
