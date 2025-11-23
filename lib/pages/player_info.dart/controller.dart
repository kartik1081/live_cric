import 'package:flutter/material.dart';
import 'package:live_cric/models/crt/crt_team_player_model.dart';

class PlayerInfoController extends ChangeNotifier {
  late final CrtTeamPlayerModel player;

  bool _mounted = false;

  PlayerInfoController(BuildContext context, {required this.player}) {
    _mounted = true;
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }

  void notify() {
    if (_mounted) notifyListeners();
  }
}
