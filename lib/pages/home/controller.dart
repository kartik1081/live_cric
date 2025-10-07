import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:live_cric/models/crt_match_model.dart';
import 'package:live_cric/models/crt_match_type_model.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/response_data.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class HomeController extends ChangeNotifier {
  PageController pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
  bool _mounted = false;
  bool _loading = true;
  List<CrtMatchTypeModel> _matchTypes = [];

  bool get loading => _loading;
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
      final data = jsonDecode(ResponseData.liveMatches);
      final List<CrtMatchTypeModel> x = [];
      for (Map<String, dynamic> matchType in data[typeMatchesKey]) {
        String mType = matchType[matchTypeKey];
        List<CrtMatchModel> matchList = [];
        if (matchType[seriesMatchesKey] != null) {
          for (var series in matchType[seriesMatchesKey]) {
            if (series[seriesAdWrapperKey] != null) {
              for (var match in series[seriesAdWrapperKey][matchesKey]) {
                matchList.add(CrtMatchModel.fromJson(match));
              }
            }
          }
        }
        x.add(CrtMatchTypeModel(matchType: mType, matchList: matchList));
      }
      _matchTypes = x;
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

  void notify() {
    if (_mounted) notifyListeners();
  }
}
