import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:live_cric/models/crt/crt_match_model.dart';
import 'package:live_cric/models/crt/crt_match_type_model.dart';
import 'package:live_cric/network_services/network_endpoint.dart';
import 'package:live_cric/network_services/network_utils.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/configs.dart';
import 'package:live_cric/utils/const.dart';
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

  Future<dynamic> getStreamingLink(
    BuildContext context, {
    required CrtMatchModel match,
  }) async {
    if (!await Common.checkNetwork(context)) return null;

    _streamLinkLoading = true;
    notify();
    try {
      return await Configs.firestore
          .collection(streamLinksFc)
          .doc(0.toString())
          .get()
          .then((value) async {
            if (value.exists &&
                value.data() != null &&
                ((value.data()?[streamUrlsKey] as List<dynamic>?) ?? [])
                    .isNotEmpty) {
              if (context.mounted) {
                return await Navigator.pushNamed(
                  context,
                  Routes.videoStreamRt,
                  arguments: {
                    matchKey: match,
                    streamUrlKey: value.data()![streamUrlsKey][0],
                  },
                );
              }
            } else {
              if (context.mounted) {
                return await Navigator.pushNamed(
                  context,
                  Routes.scorecardRt,
                  arguments: {matchIdKey: match.matchId},
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
