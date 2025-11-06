import 'dart:async';
import 'dart:convert';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live_cric/models/crt/crt_match_comm_model.dart';
import 'package:live_cric/models/crt/crt_match_model.dart';
import 'package:live_cric/network_services/network_endpoint.dart';
import 'package:live_cric/network_services/network_utils.dart';
import 'package:live_cric/utils/ads.dart';
import 'package:live_cric/utils/common.dart';
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
  Timer? timer;
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
      match.matchId.toString(),
      defaultValue: 300,
    );
    adInit(context);
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
    timer?.cancel();
    nb.setValue(match.matchId.toString(), _lastStreamingSeconds);
  }

  void adInit(BuildContext context) {
    timer = Timer.periodic(1.seconds, (t) async {
      _lastStreamingSeconds--;
      if (_lastStreamingSeconds % 300 == 0) {
        timer?.cancel();
        controller.pause();
        Ads.showInterstitialAd(
          true,
          onDismiss: () async {
            _lastStreamingSeconds = 300;
            adInit(context);
            await Future.delayed(100.milliseconds);
            controller.play();
          },
        );
      }
      notify();
    });
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
        default:
          throw Exception([response.statusCode]);
      }
    } catch (e) {
      nb.log("getCommentry: $e");
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
