import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:live_cric/models/crt/crt_match_type_model.dart';
import 'package:live_cric/pages/home/controller.dart';
import 'package:live_cric/pages/home/widgets/copyright_box.dart';
import 'package:live_cric/pages/home/widgets/match_tile.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/configs.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/routes.dart';
import 'package:live_cric/utils/widgets/custom_native.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart' hide black;
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Row(
                  children: [
                    InkWell(
                      onTap: () => RemoteConfigs.showCopyrightRc
                          ? nb.showInDialog(
                              barrierDismissible: false,
                              backgroundColor: popUp,
                              context,
                              builder: (p0) => CopyrightBox(),
                            )
                          : null,
                      onLongPress: () async => await Clipboard.setData(
                        ClipboardData(
                          text: Configs.auth.currentUser?.uid ?? "",
                        ),
                      ),
                      child: Row(
                        children: [
                          Lottie.asset('assets/lotties/live.json', width: 35.w),
                          Text(
                            "LiveCric",
                            style: Common.textStyle(isSpl: true, size: 22.sp),
                          ),
                          if (RemoteConfigs.showCopyrightRc) ...[
                            SizedBox(width: 5.w),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              decoration: BoxDecoration(
                                borderRadius: nb.radius(100.r),
                                border: BoxBorder.all(color: primary50),
                              ),
                              child: Text(
                                "C",
                                style: Common.textStyle(
                                  color: primary50,
                                  weight: FontWeight.w700,
                                  size: 10.sp,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 80.w,
                      height: 30.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: primary50,
                        borderRadius: nb.radius(12.r),
                      ),
                      child: Text(
                        "Team Info",
                        style: Common.textStyle(
                          color: black,
                          weight: FontWeight.w700,
                          size: 13.sp,
                        ),
                      ),
                    ).onTap(() {
                      Common.tapListener();
                      Navigator.pushNamed(context, Routes.teamListRt);
                    }),
                  ],
                ).paddingSymmetric(horizontal: 22.w),
                SizedBox(height: 13.h),
                if (RemoteConfigs.eventRc.isNotEmpty &&
                    RemoteConfigs.eventRc["image_url"] != null)
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child:
                        Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: RemoteConfigs.eventRc["image_url"],
                              fit: BoxFit.cover,
                            ).cornerRadiusWithClipRRect(12.r),
                            Positioned(
                              bottom: 13.h,
                              right: 13.w,
                              child: Container(
                                width: 100.w,
                                height: 40.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: primary50,
                                  borderRadius: nb.radius(12.r),
                                ),
                                child: Text(
                                  "Visit Event",
                                  style: Common.textStyle(
                                    color: black,
                                    weight: FontWeight.w700,
                                    size: 13.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ).onTap(
                          () => Navigator.pushNamed(
                            context,
                            Routes.webStreamRt,
                            arguments: {urlKey: RemoteConfigs.eventRc["url"]},
                          ),
                        ),
                  ).paddingOnly(left: 22.w, right: 22.w, bottom: 22.h),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                  onRefresh: () async =>
                                      Provider.of<HomeController>(
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
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount:
                                        Provider.of<HomeController>(
                                              context,
                                              listen: false,
                                            ).matchTypes
                                            .elementAt(index)
                                            .matchList
                                            .length,
                                    itemBuilder: (p0, index2) {
                                      final element =
                                          Provider.of<HomeController>(
                                                context,
                                                listen: false,
                                              ).matchTypes
                                              .elementAt(index)
                                              .matchList[index2];
                                      return element == null
                                          ? CustomNative(
                                              nativeType: nativeSmall,
                                              nativeId:
                                                  RemoteConfigs.nativeAdRc.adId,
                                              showNative: true,
                                              bannerType: AdSize.largeBanner,
                                              bannerId:
                                                  RemoteConfigs.bannerAdRc.adId,
                                              showBanner: true,
                                              bottomPadding: 13,
                                            )
                                          : MatchTile(
                                              match: element,
                                            ).paddingBottom(13.h);
                                    },
                                  ).paddingTop(15.h),
                                ),
                              ),
                            ).expand(),
                          ],
                        ),
                ).expand(),
                CustomNative(
                  nativeType: "",
                  bannerType: AdSize.fullBanner,
                  nativeId: "",
                  bannerId: RemoteConfigs.bannerAdRc.adId,
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
            Selector<HomeController, bool>(
              selector: (p0, p1) => p1.streamLinkLoading,
              builder: (context, streamLinkLoading, child) => Stack(
                children: [
                  if (streamLinkLoading) ...[
                    Container(color: Colors.black54),
                    Common.loader(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
