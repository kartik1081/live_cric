import 'package:intl/intl.dart';
import 'package:live_cric/utils/const.dart';

class CrtScheduleMatchModel {
  final CrtScheduleMatchInfoModel matchInfo;

  CrtScheduleMatchModel({required this.matchInfo});
  factory CrtScheduleMatchModel.fromJson(Map<String, dynamic> json) =>
      CrtScheduleMatchModel(
        matchInfo: CrtScheduleMatchInfoModel.fromJson(json[matchInfoKey]),
      );
}

class CrtScheduleMatchInfoModel {
  final int matchId;
  final int seriesId;
  final String seriesName;
  final String matchFormat;
  final String startDate;
  final String endDate;
  final String state;
  final ScheduleMatchTeam team1;
  final ScheduleMatchTeam team2;
  final ScheduledMatchVenueModel venue;

  CrtScheduleMatchInfoModel({
    required this.matchId,
    required this.seriesId,
    required this.seriesName,
    required this.matchFormat,
    required this.startDate,
    required this.endDate,
    required this.state,
    required this.team1,
    required this.team2,
    required this.venue,
  });

  factory CrtScheduleMatchInfoModel.fromJson(Map<String, dynamic> json) =>
      CrtScheduleMatchInfoModel(
        matchId: json[matchIdKey],
        seriesId: json[seriesIdKey],
        seriesName: json[seriesNameKey],
        matchFormat: json[matchFormatKey],
        startDate: DateFormat("dd").format(
          DateTime.fromMillisecondsSinceEpoch(
            int.parse(json[startDateKey]),
          ).toLocal(),
        ),
        endDate: DateFormat("dd MMM").format(
          DateTime.fromMillisecondsSinceEpoch(
            int.parse(json[endDateKey]),
          ).toLocal(),
        ),
        state: json[stateKey],
        team1: ScheduleMatchTeam.fromJson(json[team1Key]),
        team2: ScheduleMatchTeam.fromJson(json[team2Key]),
        venue: ScheduledMatchVenueModel.fromJson(json[venueInfoKey]),
      );
}

class ScheduleMatchTeam {
  final int teamId;
  final String teamName;
  final String teamSname;
  final int imageId;

  ScheduleMatchTeam({
    required this.teamId,
    required this.teamName,
    required this.teamSname,
    required this.imageId,
  });

  factory ScheduleMatchTeam.fromJson(Map<String, dynamic> json) =>
      ScheduleMatchTeam(
        teamId: json[teamIdKey],
        teamName: json[teamNameKey],
        teamSname: json[teamSNameKey],
        imageId: json[imageIdKey],
      );
}

class ScheduledMatchVenueModel {
  final int id;
  final String ground;
  final String city;

  ScheduledMatchVenueModel({
    required this.id,
    required this.ground,
    required this.city,
  });

  factory ScheduledMatchVenueModel.fromJson(Map<String, dynamic> json) =>
      ScheduledMatchVenueModel(
        id: json[idKey],
        ground: json[groundKey],
        city: json[cityKey],
      );
}
