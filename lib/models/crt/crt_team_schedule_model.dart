import 'package:live_cric/models/crt/crt_schedule_match_model.dart';
import 'package:live_cric/utils/const.dart';

class CrtTeamScheduleModel {
  final String key;
  final List<CrtScheduleMatchModel> match;

  CrtTeamScheduleModel({required this.key, required this.match});

  factory CrtTeamScheduleModel.fromJson(Map<String, dynamic> json) =>
      CrtTeamScheduleModel(
        key: json[keyKey],
        match: (json[matchKey] as List<dynamic>)
            .map((e) => CrtScheduleMatchModel.fromJson(e))
            .toList(),
      );
}
