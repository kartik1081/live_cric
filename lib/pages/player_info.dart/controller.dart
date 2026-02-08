import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:live_cric/models/crt/crt_player_info_model.dart';
import 'package:live_cric/network_services/network_endpoint.dart';
import 'package:live_cric/network_services/network_utils.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/configs.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class PlayerInfoController extends ChangeNotifier {
  late final dynamic playerId;

  bool _mounted = false;
  bool _loading = true;
  CrtPlayerInfoModel? _playerInfo;

  bool get loading => _loading;
  CrtPlayerInfoModel? get playerInfo => _playerInfo;

  PlayerInfoController(BuildContext context, {required this.playerId}) {
    _mounted = true;
    getPlayerInfo(context);
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }

  void getPlayerInfo(BuildContext context, [bool load = false]) async {
    if (!await Common.checkNetwork(context)) return;

    if (load) {
      _loading = true;
      notify();
    }
    try {
      final response = await buildHttpResponse("$playerInfoEp/$playerId");

      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          _playerInfo = CrtPlayerInfoModel.fromJson(data);
          break;
        default:
          throw Exception("${response.statusCode}");
      }
    } catch (e, s) {
      nb.log("getPlayerInfo: $e");
      Configs.crashlytics.recordError(e, s, reason: "getPlayerInfo");
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
