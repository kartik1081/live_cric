import 'package:intl/intl.dart';
import 'package:live_cric/utils/const.dart';

class CrtMatchModel {
  final int matchId;
  final int seriesId;
  final String seriesName;
  final String matchDesc;
  final String matchFormat;
  final String date;
  final String state;
  String status;
  final CrtTeamModel team1;
  final CrtTeamModel team2;
  final CrtMatchVenueModel venue;
  final List<CrtTeamIngScoreModel> team1Scores;
  final List<CrtTeamIngScoreModel> team2Scores;

  CrtMatchModel({
    required this.matchId,
    required this.seriesId,
    required this.seriesName,
    required this.matchDesc,
    required this.matchFormat,
    required this.date,
    required this.state,
    required this.status,
    required this.team1,
    required this.team2,
    required this.venue,
    required this.team1Scores,
    required this.team2Scores,
  });

  factory CrtMatchModel.fromJson(Map<String, dynamic> json) => CrtMatchModel(
    matchId: json[matchInfoKey][matchIdKey],
    seriesId: json[matchInfoKey][seriesIdKey],
    seriesName: json[matchInfoKey][seriesNameKey],
    matchDesc: json[matchInfoKey][matchDescKey],
    matchFormat: json[matchInfoKey][matchFormatKey],
    date: DateFormat("EEE, dd MMM - h:mm a").format(
      DateTime.fromMillisecondsSinceEpoch(
        int.parse(json[matchInfoKey][startDateKey]),
      ).toLocal(),
    ),
    state: json[matchInfoKey][stateKey],
    status: json[matchInfoKey][statusKey],
    team1: CrtTeamModel.fromJson(json[matchInfoKey][team1Key]),
    team2: CrtTeamModel.fromJson(json[matchInfoKey][team2Key]),
    venue: CrtMatchVenueModel.fromJson(json[matchInfoKey][venueInfoKey]),
    team1Scores: json[matchScoreKey]?[team1ScoreKey] == null
        ? []
        : (json[matchScoreKey][team1ScoreKey] as Map<String, dynamic>).values
              .toList()
              .map((e) => CrtTeamIngScoreModel.fromJson(e))
              .toList(),
    team2Scores: json[matchScoreKey]?[team2ScoreKey] == null
        ? []
        : (json[matchScoreKey][team2ScoreKey] as Map<String, dynamic>).values
              .toList()
              .map((e) => CrtTeamIngScoreModel.fromJson(e))
              .toList(),
  );
}

class CrtTeamModel {
  final int teamId;
  final String teamName;
  final String teamSName;
  final int imageId;

  CrtTeamModel({
    required this.teamId,
    required this.teamName,
    required this.teamSName,
    required this.imageId,
  });

  factory CrtTeamModel.fromJson(Map<String, dynamic> json) => CrtTeamModel(
    teamId: json[teamIdKey],
    teamName: json[teamNameKey],
    teamSName: json[teamSNameKey],
    imageId: json[imageIdKey],
  );
}

class CrtMatchVenueModel {
  final int id;
  final String ground;
  final String city;

  CrtMatchVenueModel({
    required this.id,
    required this.ground,
    required this.city,
  });

  factory CrtMatchVenueModel.fromJson(Map<String, dynamic> json) =>
      CrtMatchVenueModel(
        id: json[idKey],
        ground: json[groundKey],
        city: json[cityKey],
      );
}

class CrtTeamIngScoreModel {
  final int inningsId;
  int runs;
  int wickets;
  double overs;
  final bool? isDeclared;

  CrtTeamIngScoreModel({
    required this.inningsId,
    required this.runs,
    required this.wickets,
    required this.overs,
    this.isDeclared,
  });

  factory CrtTeamIngScoreModel.fromJson(Map<String, dynamic> json) =>
      CrtTeamIngScoreModel(
        inningsId: json[inningsIdKey],
        runs: json[runsKey] ?? 0,
        wickets: json[wicketsKey] ?? 0,
        overs: json[oversKey],
        isDeclared: json[isDeclaredKey],
      );
}
