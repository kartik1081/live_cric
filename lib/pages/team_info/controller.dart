import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:live_cric/models/crt/crt_team_model.dart';
import 'package:live_cric/models/crt/crt_team_schedule_model.dart';
import 'package:live_cric/network_services/network_endpoint.dart';
import 'package:live_cric/network_services/network_utils.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class TeamInfoController extends ChangeNotifier {
  late final CrtTeamModel team;

  bool _mounted = false;
  bool _loading = true;
  List<dynamic> _schedules = [];

  bool get loading => _loading;
  List<dynamic> get schedules => _schedules;

  TeamInfoController(BuildContext context, {required this.team}) {
    _mounted = true;
    getTeamSchedules(context);
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }

  void getTeamSchedules(BuildContext context, [bool load = false]) async {
    if (!await Common.checkNetwork(context)) return;

    if (load) {
      _loading = true;
      notify();
    }
    try {
      final response = await buildHttpResponse(
        teamScheduleEp,
        method: nb.HttpMethodType.GET,
      );

      switch (response.statusCode) {
        case 200:
          _schedules = [];
          final data = jsonDecode(response.body);
          final schedules = (data[teamMatchesDataKey] as List<dynamic>);
          schedules.retainWhere(
            (element) => element[matchDetailsMapKey] != null,
          );
          for (var i = 0; i < schedules.length; i++) {
            if (i % 2 == 1) {
              _schedules.add(null);
            }
            _schedules.add(
              CrtTeamScheduleModel.fromJson(schedules[i][matchDetailsMapKey]),
            );
          }
          break;
        case 404:
          _schedules = [];
          break;
        default:
          throw Exception("${response.statusCode}");
      }
    } catch (e) {
      nb.log("getTeamSchedules: $e");
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
