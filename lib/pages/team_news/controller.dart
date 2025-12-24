import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:live_cric/models/crt/crt_news_model.dart';
import 'package:live_cric/models/crt/crt_team_model.dart';
import 'package:live_cric/network_services/network_endpoint.dart';
import 'package:live_cric/network_services/network_utils.dart';
import 'package:live_cric/utils/common.dart';
import 'package:live_cric/utils/configs.dart';
import 'package:live_cric/utils/const.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class TeamNewsController extends ChangeNotifier {
  late final CrtTeamModel team;

  bool _mounted = false;
  bool _loading = true;
  List<dynamic> _teamNews = [];

  bool get loading => _loading;
  List<dynamic> get teamNews => _teamNews;

  TeamNewsController(BuildContext context, {required this.team}) {
    _mounted = true;
    getTeamNews(context);
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }

  void getTeamNews(BuildContext context, [bool load = false]) async {
    if (!await Common.checkNetwork(context)) return;

    if (load) {
      _loading = true;
      notify();
    }
    try {
      final response = await buildHttpResponse(
        teamNewsEp,
        method: nb.HttpMethodType.GET,
      );

      switch (response.statusCode) {
        case 200:
          _teamNews = [];
          final data = jsonDecode(response.body);
          final news = (data[storyListKey] as List<dynamic>);
          news.retainWhere((element) => element[storyKey] != null);
          for (var i = 0; i < news.length; i++) {
            if (i % 7 == 3) {
              _teamNews.add(null);
            }
            _teamNews.add(CrtNewsModel.fromJson(news[i][storyKey]));
          }
          break;
        case 404:
          _teamNews = [];
          break;
        default:
          throw Exception("${response.statusCode}");
      }
    } catch (e, s) {
      nb.log('getTeamNews: $e');
      Configs.crashlytics.recordError(e, s, reason: "getTeamNews");
      if (context.mounted) {
        Common.showSnackbar(context, nb.errorMessage);
      }
    } finally {
      _loading = false;
      notify();
    }
  }

  void notify() {
    if (_mounted) notifyListeners();
  }
}
