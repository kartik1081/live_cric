import 'dart:convert';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live_cric/models/crt/crt_match_comm_model.dart';
import 'package:live_cric/models/crt/crt_match_model.dart';
import 'package:live_cric/network_services/network_endpoint.dart';
import 'package:live_cric/network_services/network_utils.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/configs.dart';
import 'package:live_cric/utils/const.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class VideoStreamController extends ChangeNotifier {
  late final CrtMatchModel match;
  late final String streamUrl;
  late BetterPlayerController controller;
  final PageController pageController = PageController();

  bool _mounted = false;
  bool _initialLoading = true;
  bool _commentryLoading = true;
  int _lastStreamingSeconds = 300;
  CrtMatchCommModel? _comm;

  bool get initialLoading => _initialLoading;
  bool get commentryLoading => _commentryLoading;
  int get lastStreamingSeconds => _lastStreamingSeconds;
  CrtMatchCommModel? get comm => _comm;

  VideoStreamController(
    BuildContext context, {
    required this.match,
    required this.streamUrl,
  }) {
    _mounted = true;
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      streamUrl,
      liveStream: true,
      videoFormat: BetterPlayerVideoFormat.hls,
      // drmConfiguration: BetterPlayerDrmConfiguration(
      //   drmType: BetterPlayerDrmType.widevine,
      //   licenseUrl:
      //       "https://raw.githubusercontent.com/cricstream4u/sports/refs/heads/main/sports.json",
      // ),
    );

    controller = BetterPlayerController(
      BetterPlayerConfiguration(
        aspectRatio: 16 / 9,
        autoPlay: true,
        fit: BoxFit.contain,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
        deviceOrientationsOnFullScreen: [
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ],
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableSkips: false,
          enableFullscreen: true,
        ),
      ),
      betterPlayerDataSource: dataSource,
    );
    _lastStreamingSeconds = nb.getIntAsync(
      cricketStreamingSecondKey,
      defaultValue: 300,
    );
    _initialLoading = false;
    notify();
    getCommentry(context, load: true);
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
    _initialLoading = false;
    controller.pause();
    controller.dispose();
    nb.setValue(cricketStreamingSecondKey, _lastStreamingSeconds);
  }

  void getCommentry(BuildContext context, {bool load = false}) async {
    if (!await Common.checkNetwork(context)) return;

    if (load) {
      _commentryLoading = true;
      notify();
    }
    try {
      final response = await buildHttpResponse(
        getCommentryEp(match.matchId),
        method: nb.HttpMethodType.GET,
      );

      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          _comm = CrtMatchCommModel.fromJson(data);
          nb.log("getCommentry: ${_comm?.curovsstats}");
          break;
        case 429:
          if (context.mounted) {
            Common.showSnackbar(context, nb.errorMessage);
          }
          break;
        default:
          throw Exception([response.statusCode]);
      }
    } catch (e, s) {
      nb.log("getCommentry: $e");
      Configs.crashlytics.recordError(e, s, reason: "getCommentry");
      if (context.mounted) {
        Common.showSnackbar(
          context,
          "Failed to load Commentry! ${nb.errorMessage}",
        );
      }
    } finally {
      _commentryLoading = false;
      notify();
    }
  }

  void notify() {
    if (_mounted) notifyListeners();
  }
}
