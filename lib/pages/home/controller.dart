import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/models/crt/crt_match_model.dart';
import 'package:live_cric/models/crt/crt_match_type_model.dart';
import 'package:live_cric/network_services/network_endpoint.dart';
import 'package:live_cric/network_services/network_utils.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/configs.dart';
import 'package:live_cric/utils/const.dart';
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
    getMatchesList(context);
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
          for (Map<String, dynamic> matchType in data[typeMatchesKey]) {
            String mType = matchType[matchTypeKey];
            List<CrtMatchModel?> matchList = [];
            if (matchType[seriesMatchesKey] != null) {
              for (var series in matchType[seriesMatchesKey]) {
                if (series[seriesAdWrapperKey] != null) {
                  for (var match in series[seriesAdWrapperKey][matchesKey]) {
                    matchList.add(CrtMatchModel.fromJson(match));
                    if (matchList.where((element) => element != null).length %
                            2 ==
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
          if (_selectedIndex >= _matchTypes.length) --_selectedIndex;
          break;
        case 404:
          _matchTypes = [];
          break;
        case 401:
          if (context.mounted) {
            Common.showSnackbar(context, "Try again later!");
          }
          break;
        default:
          throw Exception([response.statusCode]);
      }
    } catch (e) {
      nb.log("getMatchesList: $e");
      if (context.mounted) {
        Common.showSnackbar(context, nb.errorSomethingWentWrong);
      }
    } finally {
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
          .doc(
            RemoteConfigs.demoStreamRc
                ? 1.toString()
                : match.matchId.toString(),
          )
          .get()
          .then((value) async {
            if (value.exists &&
                value.data() != null &&
                ((value.data()?[urlsKey] as List<dynamic>?) ?? []).isNotEmpty) {
              final streamLink = value.data()?[urlsKey];
              if (context.mounted) {
                // await Navigator.pushNamed(
                //   context,
                //   Routes.videoStreamRt,
                //   arguments: {
                //     matchKey: match,
                //     streamUrlKey: value.data()![streamUrlsKey][0],
                //   },
                // );

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
                        child: streamLink.isEmpty
                            ? Text(
                                "No Server Found.",
                                style: Common.textStyle(color: Colors.grey),
                              ).center()
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(top: 13.h),
                                itemCount: streamLink.length,
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
                                        streamLink[index][isStreamKey]
                                            ? Routes.videoStreamRt
                                            : Routes.videoStreamRt,
                                        arguments: {
                                          matchKey: match,
                                          urlKey: streamLink[index][urlKey],
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
                await Navigator.pushNamed(
                  context,
                  Routes.scorecardRt,
                  arguments: {matchKey: match},
                );
              }
            }
          });
    } catch (e) {
      nb.log("getStreamingLink: $e");
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
