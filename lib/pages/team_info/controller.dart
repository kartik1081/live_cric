import 'package:flutter/material.dart';

class TeamInfoController extends ChangeNotifier {
  bool _mounted = false;
  bool _loading = false;

  bool get loading => _loading;

  TeamInfoController(BuildContext context) {
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
