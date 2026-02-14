import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:live_cric/utils/ads.dart';
import 'package:live_cric/utils/color.dart';
import 'package:live_cric/utils/remote_configs.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:url_launcher/url_launcher.dart';

class Common {
  static const _charts =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
  static final Random _rnd = Random.secure();
  static final ReceivePort _receivePort = ReceivePort();
  static final StreamController<bool> _showInsterstitialAds =
      StreamController<bool>.broadcast();
  static int _tapCount = 0;

  static StreamController<bool> get showInsterstitialAds =>
      _showInsterstitialAds;

  static TextStyle textStyle({
    Color? color,
    double? size,
    FontWeight? weight,
    TextDecoration? textDecoration,
    Color? textDecorationColor,
    double? latterSpace,
    bool isSpl = false,
  }) => TextStyle(
    fontFamily: isSpl ? "dr" : "gr",
    color: color ?? soft,
    fontSize: size ?? 16.sp,
    fontWeight: weight ?? FontWeight.w400,
    decoration: textDecoration ?? TextDecoration.none,
    decorationColor: color ?? soft,
    letterSpacing: latterSpace,
  );

  static Future<bool> checkNetwork(BuildContext context) async {
    if (!await nb.isNetworkAvailable()) {
      if (context.mounted) {
        showSnackbar(context, nb.errorInternetNotAvailable);
      }
      return false;
    }
    return true;
  }

  static void showSnackbar(BuildContext context, String msg) => nb.snackBar(
    context,
    content: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, color: text),
        SizedBox(width: 13.w),
        Text(msg, style: Common.textStyle(color: text)).expand(),
      ],
    ),
    backgroundColor: popUp,
    margin: EdgeInsets.all(13.w),
    shape: RoundedRectangleBorder(borderRadius: nb.radius(54.r)),
  );

  static Widget loader({Color? color, int size = 35}) =>
      LoadingAnimationWidget.fourRotatingDots(
        color: color ?? soft,
        size: size.w,
      ).center();

  static String generateId({int length = 16}) {
    if (length <= 0) return "";

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (index) => _charts.codeUnitAt(_rnd.nextInt(_charts.length)),
      ),
    );
  }

  static void initAds() {
    Isolate.spawn(sendAdSignal, [
      _receivePort.sendPort,
      RootIsolateToken.instance!,
      RemoteConfigs.interstitialAdIntervalRc.seconds,
    ]);
    _receivePort.listen((message) {
      if (message is bool) {
        Ads.loadInterstitial();
      }
    });
  }

  static void sendAdSignal(dynamic args) async {
    final SendPort sendPort = args[0];
    BackgroundIsolateBinaryMessenger.ensureInitialized(args[1]);
    final Duration duration = args[2];
    Timer.periodic(duration, (timer) async {
      sendPort.send(true);
    });
  }

  static void sendNotification(String title, String body) async {
    if (!await nb.isNetworkAvailable()) return;

    try {
      await http.post(
        Uri.parse("https://sendNotificationToTopic-k45khh27kq-uc.a.run.app"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"title": title, "body": body}),
      );
    } catch (e) {
      nb.log("sendNotification: $e");
    }
  }

  static void tapListener() {
    if (RemoteConfigs.affLinksRc["show"] &&
        RemoteConfigs.affLinksRc["links"].isNotEmpty) {
      ++_tapCount;
      if (_tapCount % RemoteConfigs.affLinksRc["tap_count"] == 1) {
        launchUrl(
          Uri.parse(
            RemoteConfigs.affLinksRc["links"][Random().nextInt(
              RemoteConfigs.affLinksRc["links"].length,
            )],
          ),
          mode: LaunchMode.inAppBrowserView,
        );
      }
    }
  }
}
