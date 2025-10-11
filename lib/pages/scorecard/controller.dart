import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:live_cric/models/crt/crt_match_info.dart';
import 'package:live_cric/models/crt/crt_match_scorecard_model.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/response_data.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class ScorecardController extends ChangeNotifier {
  late final int matchId;

  bool _mounted = false;
  bool _loading = true;
  CrtMatchScorecardModel? _scorecardModel;
  CrtMatchInfoModel? _matchInfo;

  bool get loading => _loading;
  CrtMatchScorecardModel? get scorecardModel => _scorecardModel;
  CrtMatchInfoModel? get matchInfo => _matchInfo;

  ScorecardController(BuildContext context, {required this.matchId}) {
    _mounted = true;
    getScorecard(context);
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }

  Future<void> getScorecard(BuildContext context, {bool load = false}) async {
    if (!await Common.checkNetwork(context)) return;

    if (load) {
      _loading = true;
      notify();
    }

    try {
      // final response = await buildHttpResponse(
      //   getMatchScorecardEp(matchId),
      //   method: nb.HttpMethodType.GET,
      // );

      // switch (response.statusCode) {
      //   case 200:
      final data = jsonDecode(ResponseData.scorecard);
      _scorecardModel = CrtMatchScorecardModel.fromJson(data);
      if (context.mounted) {
        await getMatchInfo(context);
      }
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
      _loading = false;
      notify();
    }
  }

  Future<void> getMatchInfo(BuildContext context, {bool load = false}) async {
    if (!await Common.checkNetwork(context)) return;

    try {
      // final response = await buildHttpResponse(
      //   getMatchInfoEp(matchId),
      //   method: nb.HttpMethodType.GET,
      // );

      // switch (response.statusCode) {
      //   case 200:
      final data = jsonDecode(ResponseData.matchInfo);
      _matchInfo = CrtMatchInfoModel.fromJson(data);
      //     break;
      //   default:
      //     throw Exception([response.statusCode]);
      // }
    } catch (e) {
      nb.log("getMatchInfo: $e");
      if (context.mounted) {
        Common.showSnackbar(context, nb.errorSomethingWentWrong);
      }
    }
  }

  void notify() {
    if (_mounted) notifyListeners();
  }
}
