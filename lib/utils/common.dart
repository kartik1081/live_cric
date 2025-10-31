import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_cric/utils/color.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class Common {
  static const _charts =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
  static final Random _rnd = Random.secure();

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
}
