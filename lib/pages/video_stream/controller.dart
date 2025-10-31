import 'dart:async';
import 'dart:convert';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live_cric/models/crt/crt_match_model.dart';
import 'package:live_cric/models/crt/crt_match_scorecard_model.dart';
import 'package:live_cric/utils/ads.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/response_data.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class VideoStreamController extends ChangeNotifier {
  late final CrtMatchModel match;
  late final String streamUrl;
  late BetterPlayerController controller;
  final PageController pageController = PageController();

  bool _mounted = false;
  bool _initialLoading = true;
  bool _scorecardLoading = true;
  int _lastStreamingSeconds = 300;
  Timer? timer;
  CrtMatchScorecardModel? _scorecardModel;

  bool get initialLoading => _initialLoading;
  bool get scorecardLoading => _scorecardLoading;
  int get lastStreamingSeconds => _lastStreamingSeconds;
  CrtMatchScorecardModel? get scorecardModel => _scorecardModel;

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
    getScorecard(context, load: true);
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
    _initialLoading = false;
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

  Future<void> getScorecard(BuildContext context, {bool load = false}) async {
    if (!await Common.checkNetwork(context)) return;

    if (load) {
      _scorecardLoading = true;
      notify();
    }

    try {
      // final response = await buildHttpResponse(
      //   getMatchScorecardEp(matchId),
      //   method: nb.HttpMethodType.GET,
      // );

      // switch (response.statusCode) {
      //   case 200:
      await Future.delayed(3.seconds);
      final data = jsonDecode(ResponseData.scorecard);
      _scorecardModel = CrtMatchScorecardModel.fromJson(data);
      // if (context.mounted) {
      //   await getMatchInfo(context);
      // }
      //     break;
      //   default:
      //     throw Exception([response.statusCode]);
      // }
    } catch (e) {
      nb.log("getScorecard: $e");
      if (context.mounted) {
        Common.showSnackbar(context, nb.errorSomethingWentWrong);
      }
    } finally {
      _scorecardLoading = false;
      notify();
    }
  }

  void notify() {
    if (_mounted) notifyListeners();
  }
}
