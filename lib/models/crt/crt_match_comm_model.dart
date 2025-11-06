import 'package:intl/intl.dart';
import 'package:live_cric/utils/const.dart';

class CrtMatchCommModel {
  final Batsman? strikerBatsman;
  final Batsman? nonStrikerBatsman;
  final Bowler? strikerBowler;
  final Bowler? nonStrikerBowler;
  final double crr;
  final double rrr;
  final String lastwkt;
  final List<String> curovsstats;
  final String partnership;
  final MatchHeadersModel matchHeaders;

  CrtMatchCommModel({
    required this.strikerBatsman,
    required this.nonStrikerBatsman,
    required this.strikerBowler,
    required this.nonStrikerBowler,
    required this.crr,
    required this.rrr,
    required this.lastwkt,
    required this.curovsstats,
    required this.partnership,
    required this.matchHeaders,
  });

  factory CrtMatchCommModel.fromJson(Map<String, dynamic> json) =>
      CrtMatchCommModel(
        strikerBatsman: json[miniscoreKey]?[batsmanstrikerKey] == null
            ? null
            : Batsman.fromJson(json[miniscoreKey]?[batsmanstrikerKey]),
        nonStrikerBatsman: json[miniscoreKey]?[batsmannonstrikerKey] == null
            ? null
            : Batsman.fromJson(json[miniscoreKey]?[batsmannonstrikerKey]),
        strikerBowler: json[miniscoreKey][bowlerstrikerKey] == null
            ? null
            : Bowler.fromJson(json[miniscoreKey]?[bowlerstrikerKey]),
        nonStrikerBowler: json[miniscoreKey]?[bowlernonstrikerKey] == null
            ? null
            : Bowler.fromJson(json[miniscoreKey]?[bowlernonstrikerKey]),
        crr: json[miniscoreKey]?[crrKey] ?? 0.0,
        rrr: json[miniscoreKey]?[rrrKey] ?? 0.0,
        lastwkt: json[miniscoreKey]?[lastwktKey] ?? "",
        curovsstats:
            (((json[miniscoreKey]?[curovsstatsKey] ?? "") as String).replaceAll(
              " |",
              "|",
            )).split(" ")..remove(""),
        partnership: json[miniscoreKey]?[partnershipKey] ?? "0(0)",
        matchHeaders: MatchHeadersModel.fromJson(json[matchheadersKey]),
      );
}

class Batsman {
  final int id;
  final String name;
  final int balls;
  final int runs;
  final int fours;
  final int sixes;
  final String sr;

  Batsman({
    required this.id,
    required this.name,
    required this.balls,
    required this.runs,
    required this.fours,
    required this.sixes,
    required this.sr,
  });

  factory Batsman.fromJson(Map<String, dynamic> json) => Batsman(
    id: json[idKey],
    name: json[nameKey],
    balls: json[ballsKey],
    runs: json[runsKey],
    fours: json[foursKey],
    sixes: json[sixesKey],
    sr: NumberFormat("00.00").format(double.parse(json[strkrateKey])),
  );
}

class Bowler {
  final int id;
  final String name;
  final String overs;
  final int maidens;
  final int runs;
  final int wickets;
  final String eco;

  Bowler({
    required this.id,
    required this.name,
    required this.overs,
    required this.maidens,
    required this.runs,
    required this.wickets,
    required this.eco,
  });

  factory Bowler.fromJson(Map<String, dynamic> json) => Bowler(
    id: json[idKey],
    name: json[nameKey],
    overs: json[oversKey],
    maidens: json[maidensKey],
    runs: json[runsKey],
    wickets: json[wicketsKey],
    eco: json[economyKey],
  );
}

class MatchHeadersModel {
  final String state;
  final String status;
  final List<MomPlayerModel> momPlayers;

  MatchHeadersModel({
    required this.state,
    required this.status,
    required this.momPlayers,
  });

  factory MatchHeadersModel.fromJson(Map<String, dynamic> json) =>
      MatchHeadersModel(
        state: json[stateKey],
        status: json[statusKey],
        momPlayers: ((json[momplayersKey]?[playerKey] ?? []) as List<dynamic>)
            .map((e) => MomPlayerModel.fromJson(e))
            .toList(),
      );
}

class MomPlayerModel {
  final String id;
  final String name;

  MomPlayerModel({required this.id, required this.name});

  factory MomPlayerModel.fromJson(Map<String, dynamic> json) =>
      MomPlayerModel(id: json[idKey], name: json[nameKey]);
}
