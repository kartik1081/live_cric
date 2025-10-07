import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/models/crt_match_type_model.dart';
import 'package:live_cric/pages/home/controller.dart';
import 'package:live_cric/pages/home/widgets/match_tile.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart' hide black;
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          Row(
            children: [
              Lottie.asset('assets/lotties/live.json', width: 35.w),
              Text(
                "LiveCric",
                style: Common.textStyle(isSpl: true, size: 22.sp),
              ),
            ],
          ).paddingSymmetric(horizontal: 22.w),
          SizedBox(height: 13.h),
          Selector<HomeController, Tuple2<bool, List<CrtMatchTypeModel>>>(
            selector: (p0, p1) => Tuple2(p1.loading, p1.matchTypes),
            builder: (context, data, child) => data.item1
                ? Common.loader().paddingBottom(100.h)
                : data.item2.isEmpty
                ? Text(
                    "No Matches Found!",
                    style: Common.textStyle(color: text),
                  ).paddingBottom(100.h).center()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        padding: EdgeInsets.only(left: 0),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            data.item2.length,
                            (index) => Selector<HomeController, int>(
                              selector: (p0, p1) => p1.selectedIndex,
                              builder: (context, selectedIndex, child) =>
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 13.w,
                                      vertical: 7.h,
                                    ),
                                    margin: EdgeInsets.only(right: 7.w),
                                    decoration: BoxDecoration(
                                      color: selectedIndex == index
                                          ? primary50
                                          : nb.transparentColor,
                                      border: Border.all(
                                        color: selectedIndex == index
                                            ? primary50
                                            : soft,
                                      ),
                                      borderRadius: nb.radius(12.r),
                                    ),
                                    child: Text(
                                      data.item2[index].matchType,
                                      style: Common.textStyle(
                                        color: selectedIndex == index
                                            ? black
                                            : soft,
                                        weight: FontWeight.w700,
                                      ),
                                    ),
                                  ).onTap(
                                    () => Provider.of<HomeController>(
                                      context,
                                      listen: false,
                                    ).selectMatchType(index),
                                  ),
                            ),
                          ),
                        ),
                      ).paddingSymmetric(horizontal: 22.w),
                      PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: Provider.of<HomeController>(
                          context,
                          listen: false,
                        ).pageController,
                        children: List.generate(
                          data.item2.length,
                          (index) => RefreshIndicator(
                            onRefresh: () async => Provider.of<HomeController>(
                              context,
                              listen: false,
                            ).getMatchesList(context),
                            child: AnimatedListView(
                              padding: EdgeInsets.only(
                                left: 22.w,
                                right: 22.w,
                                bottom: 100.h,
                                top: 7.h,
                              ),
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: Provider.of<HomeController>(
                                context,
                                listen: false,
                              ).matchTypes.elementAt(index).matchList.length,
                              itemBuilder: (p0, index2) => MatchTile(
                                match: Provider.of<HomeController>(
                                  context,
                                  listen: false,
                                ).matchTypes.elementAt(index).matchList[index2],
                              ).paddingBottom(16.h),
                            ).paddingTop(15.h),
                          ),
                        ),
                      ).expand(),
                    ],
                  ),
          ).expand(),
        ],
      ),
    );
  }
}
