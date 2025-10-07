import 'package:flutter/material.dart';
import 'package:live_cric/utils/routes.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class SplashController extends ChangeNotifier {
  SplashController(BuildContext context) {
    Future.delayed(3.seconds).whenComplete(() {
      if (context.mounted) {
        Navigator.pushNamed(context, Routes.homeRt);
      }
    });
  }
}
