import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:live_cric/models/crt/crt_team_model.dart';
import 'package:live_cric/network_services/network_endpoint.dart';
import 'package:live_cric/network_services/network_utils.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class TeamListController extends ChangeNotifier {
  bool _mounted = false;
  bool _loading = true;
  List<dynamic> _teamList = [];

  bool get loading => _loading;
  List<dynamic> get teamList => _teamList;

  TeamListController(BuildContext context) {
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
      final response = await buildHttpResponse(
        teamListEp,
        method: nb.HttpMethodType.GET,
      );

      switch (response.statusCode) {
        case 200:
          _teamList = [];
          final data = jsonDecode(response.body);
          final teams = (data[listKey] as List<dynamic>);
          teams.retainWhere((element) => element[teamIdKey] != null);
          for (var i = 0; i < teams.length; i++) {
            if (i % 7 == 6) {
              _teamList.add(null);
            }
            _teamList.add(CrtTeamModel.fromJson(teams[i]));
          }
          break;
        case 404:
          _teamList = [];
          break;
        default:
          break;
      }
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
