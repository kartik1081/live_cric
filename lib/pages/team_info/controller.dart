import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:live_cric/models/crt/crt_team_model.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/response_data.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class TeamInfoController extends ChangeNotifier {
  bool _mounted = false;
  bool _loading = true;
  List<CrtTeamModel> _teamList = [];

  bool get loading => _loading;
  List<CrtTeamModel> get teamList => _teamList;

  TeamInfoController(BuildContext context) {
    _mounted = true;
    getTeamInfo(context);
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }

  void getTeamInfo(BuildContext context, [bool load = false]) async {
    if (!await Common.checkNetwork(context)) return;

    if (load) {
      _loading = false;
      notify();
    }
    try {
      final data = jsonDecode(ResponseData.teamInfo);
      final teams = (data[listKey] as List<dynamic>);
      teams.retainWhere((element) => element[teamIdKey] != null);
      _teamList = teams.map((e) => CrtTeamModel.fromJson(e)).toList();
    } catch (e) {
      nb.log("getTeamInfo: $e");
      if (context.mounted) {
        Common.showSnackbar(context, nb.errorMessage);
      }
    } finally {
      _loading = false;
      notify();
    }
  }

  void notify() {
    if (_mounted) notifyListeners();
  }
}
