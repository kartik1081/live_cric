import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:live_cric/models/crt/crt_team_model.dart';
import 'package:live_cric/models/crt/crt_team_player_model.dart';
import 'package:live_cric/network_services/network_endpoint.dart';
import 'package:live_cric/network_services/network_utils.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/configs.dart';
import 'package:live_cric/utils/const.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class PlayerListController extends ChangeNotifier {
  late final CrtTeamModel team;
  bool _mounted = false;
  bool _loading = true;
  List<dynamic> _playerList = [];

  bool get loading => _loading;
  List<dynamic> get playerList => _playerList;

  PlayerListController(BuildContext context, {required this.team}) {
    _mounted = true;
    getPlayerList(context);
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
    Common.tapListener();
  }

  void getPlayerList(BuildContext context, [bool load = false]) async {
    if (!await Common.checkNetwork(context)) return;

    if (load) {
      _loading = true;
      notify();
    }
    try {
      final response = await buildHttpResponse(
        teamPlayersEp,
        method: nb.HttpMethodType.GET,
      );

      switch (response.statusCode) {
        case 200:
          _playerList = [];
          final data = jsonDecode(response.body);
          final players = (data[playerKey] as List<dynamic>);
          players.retainWhere((element) => element[idKey] != null);
          for (var i = 0; i < players.length; i++) {
            if (i % 10 == 3) {
              _playerList.add(null);
            }
            _playerList.add(CrtTeamPlayerModel.fromJson(players[i]));
          }
          break;
        case 404:
          _playerList = [];
          break;
        default:
          throw Exception("${response.statusCode}");
      }
    } catch (e, s) {
      nb.log("getPlayerList: $e");
      Configs.crashlytics.recordError(e, s, reason: "getPlayerList");
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
