import 'package:flutter/material.dart';
import 'package:live_cric/models/crt/crt_team_model.dart';

class TeamNewsController extends ChangeNotifier {
  late final CrtTeamModel team;

  bool _mounted = false;

  TeamNewsController(BuildContext context, {required this.team}) {
    _mounted = false;
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
