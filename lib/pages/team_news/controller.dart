import 'package:flutter/material.dart';

class TeamNewsController extends ChangeNotifier {
  bool _mounted = false;

  TeamNewsController(BuildContext context) {
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
