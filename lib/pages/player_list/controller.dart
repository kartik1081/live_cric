import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:live_cric/models/crt/crt_team_player_model.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/response_data.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class PlayerListController extends ChangeNotifier {
  bool _mounted = false;
  bool _loading = true;
  List<CrtTeamPlayerModel> _playerList = [];

  bool get loading => _loading;
  List<CrtTeamPlayerModel> get playerList => _playerList;

  PlayerListController(BuildContext context) {
    _mounted = true;
    getPlayerList(context);
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }

  void getPlayerList(BuildContext context, [bool load = false]) async {
    if (!await Common.checkNetwork(context)) return;

    if (load) {
      _loading = true;
      notify();
    }
    try {
      final data = jsonDecode(ResponseData.teamPlayers);
      final players = (data[playerKey] as List<dynamic>);
      players.retainWhere((element) => element[idKey] != null);
      _playerList = players.map((e) => CrtTeamPlayerModel.fromJson(e)).toList();
    } catch (e) {
      nb.log("getPlayerList: $e");
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
