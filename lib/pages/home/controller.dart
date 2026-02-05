import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/models/crt/crt_match_model.dart';
import 'package:live_cric/models/crt/crt_match_type_model.dart';
import 'package:live_cric/network_services/network_endpoint.dart';
import 'package:live_cric/network_services/network_utils.dart';
import 'package:live_cric/pages/home/widgets/copyright_box.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/configs.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/notification_service.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:live_cric/utils/routes.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class HomeController extends ChangeNotifier {
  PageController pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
  bool _mounted = false;
  bool _loading = true;
  bool _streamLinkLoading = false;
  List<CrtMatchTypeModel> _matchTypes = [];

  bool get loading => _loading;
  bool get streamLinkLoading => _streamLinkLoading;
  int get selectedIndex => _selectedIndex;
  List<CrtMatchTypeModel> get matchTypes => _matchTypes;

  HomeController(BuildContext context) {
    _mounted = true;
    Common.initAds();
    getMatchesList(context);
    NotificationService.requestNotificationPermission();
    Configs.inAppReview.isAvailable().then(
      (value) async => await Configs.inAppReview.requestReview(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }

  Future<void> getMatchesList(BuildContext context, {bool load = false}) async {
    if (!await Common.checkNetwork(context)) return;

    if (load) {
      _loading = true;
      notify();
    }
    try {
      final response = await buildHttpResponse(
        matchListEp,
        method: nb.HttpMethodType.GET,
      );

      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          final List<CrtMatchTypeModel> x = [];
          for (Map<String, dynamic> matchType in (data[typeMatchesKey] ?? [])) {
            String mType = matchType[matchTypeKey];
            List<CrtMatchModel?> matchList = [];
            if (matchType[seriesMatchesKey] != null) {
              for (var series in matchType[seriesMatchesKey]) {
                if (series[seriesAdWrapperKey] != null) {
                  for (var match in series[seriesAdWrapperKey][matchesKey]) {
                    matchList.add(CrtMatchModel.fromJson(match));
                    if (matchList.where((element) => element != null).length %
                            5 ==
                        1) {
                      matchList.add(null);
                    }
                  }
                }
              }
            }
            x.add(CrtMatchTypeModel(matchType: mType, matchList: matchList));
          }
          _matchTypes = x;
          if (_matchTypes.isNotEmpty) {
            if (_selectedIndex >= _matchTypes.length) --_selectedIndex;
          }
          break;
        case 404:
          _matchTypes = [];
          break;
        case 401:
          if (context.mounted) {
            Common.showSnackbar(context, "Try again later!");
          }
          break;
        case 429:
          if (context.mounted) {
            Common.showSnackbar(context, nb.errorMessage);
          }
          break;
        default:
          throw Exception([response.statusCode]);
      }
    } catch (e, s) {
      nb.log("getMatchesList: $e");
      Configs.crashlytics.recordError(e, s, reason: "getMatchesList");
      if (context.mounted) {
        Common.showSnackbar(context, nb.errorSomethingWentWrong);
      }
    } finally {
      if (!nb.getBoolAsync(copyrightReadKey, defaultValue: true) &&
          context.mounted) {
        nb.showInDialog(
          barrierDismissible: false,
          backgroundColor: popUp,
          context,
          builder: (p0) => CopyrightBox(),
        );
      }
      _loading = false;
      notify();
    }
  }

  void selectMatchType(int index) {
    _selectedIndex = index;
    notify();
    pageController.animateToPage(
      _selectedIndex,
      duration: 300.milliseconds,
      curve: Curves.ease,
    );
  }

  Future<void> getStreamingLink(
    BuildContext context, {
    required CrtMatchModel match,
  }) async {
    if (!await Common.checkNetwork(context)) return;

    _streamLinkLoading = true;
    notify();
    try {
      await Configs.firestore
          .collection(streamLinksFc)
          .doc(match.matchId.toString())
          .get()
          .then((value) async {
            List<String> streamLinks = [
              ...(value.data()?[urlsKey] ?? []),
              ...RemoteConfigs.defaultStreamLinkRc,
            ];
            if (streamLinks.isNotEmpty) {
              if (context.mounted) {
                nb.showInDialog(
                  context,
                  backgroundColor: popUp,
                  builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Choose Server",
                        style: Common.textStyle(isSpl: true, size: 18.sp),
                      ),
                      Divider(),
                      ConstrainedBox(
                        constraints: BoxConstraints(minHeight: 70.h),
                        child: streamLinks.isEmpty
                            ? Text(
                                "No Server Found.",
                                style: Common.textStyle(color: Colors.grey),
                              ).center()
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(top: 13.h),
                                itemCount: streamLinks.length,
                                itemBuilder: (context, index) =>
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 13.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primary50,
                                        borderRadius: nb.radius(8.r),
                                      ),
                                      child: Text(
                                        "Server ${index + 1}",
                                        style: Common.textStyle(
                                          color: black,
                                          weight: FontWeight.w700,
                                          size: 18.h,
                                        ),
                                      ),
                                    ).onTap(
                                      () => Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        Routes.webStreamRt,
                                        arguments: {
                                          matchKey: match,
                                          urlKey: streamLinks[index],
                                        },
                                        (route) =>
                                            route.settings.name ==
                                            Routes.homeRt,
                                      ),
                                    ),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 10.h),
                              ),
                      ),
                    ],
                  ),
                );
              }
            } else {
              if (context.mounted) {
                if (match.state == tossSt) {
                  Common.showSnackbar(context, "Match is not started yet!");
                  return;
                } else {
                  await Navigator.pushNamed(
                    context,
                    Routes.scorecardRt,
                    arguments: {matchKey: match},
                  );
                }
              }
            }
          });
    } catch (e, s) {
      nb.log("getStreamingLink: $e");
      Configs.crashlytics.recordError(e, s, reason: "getStreamingLink");
      if (context.mounted) {
        Common.showSnackbar(context, nb.errorMessage);
      }
    } finally {
      _streamLinkLoading = false;
      notify();
    }
  }

  void notify() {
    if (_mounted) notifyListeners();
  }
}
