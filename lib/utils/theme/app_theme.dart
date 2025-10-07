import 'package:flutter/material.dart';
import 'package:live_cric/utils/color.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: black,
    useMaterial3: true,
    splashColor: nb.transparentColor,
    highlightColor: nb.transparentColor,
  );
}
