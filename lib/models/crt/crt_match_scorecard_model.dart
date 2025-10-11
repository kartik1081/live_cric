import 'package:live_cric/utils/const.dart';

class CrtMatchScorecardModel {
  final String status;
  final List<CrtMatchInnModel> inningList;

  CrtMatchScorecardModel({required this.status, required this.inningList});

  factory CrtMatchScorecardModel.fromJson(Map<String, dynamic> json) =>
      CrtMatchScorecardModel(
        status: json[statusKey],
        inningList: (json[scorecardKey] as List<dynamic>)
            .map((e) => CrtMatchInnModel.fromJson(e))
            .toList(),
      );
}

class CrtMatchInnModel {
  final int inningId;
  final int score;
  final int wickets;
  final double overs;
  final double runrate;
  final String batTeamsName;
  final List<BatsmanModel> batsman;
  final List<BowlerModel> bowlers;
  final ExtrasModel extras;
  final List<FOWModel> fow;
  final List<PowerplayModel> pp;
  final List<PartnershipModel> ps;

  CrtMatchInnModel({
    required this.inningId,
    required this.score,
    required this.wickets,
    required this.overs,
    required this.runrate,
    required this.batTeamsName,
    required this.batsman,
    required this.bowlers,
    required this.extras,
    required this.fow,
    required this.pp,
    required this.ps,
  });

  factory CrtMatchInnModel.fromJson(Map<String, dynamic> json) =>
      CrtMatchInnModel(
        inningId: json[inningsidKey],
        score: json[scoreKey],
        wickets: json[wicketsKey],
        overs: json[oversKey],
        runrate: json[runrateKey],
        batTeamsName: json[batteamsnameKey],
        batsman: json[batsmanKey] == null
            ? []
            : (json[batsmanKey] as List<dynamic>)
                  .map((e) => BatsmanModel.fromJson(e))
                  .toList(),
        bowlers: json[bowlerKey] == null
            ? []
            : (json[bowlerKey] as List<dynamic>)
                  .map((e) => BowlerModel.fromJson(e))
                  .toList(),
        extras: ExtrasModel.fromJson(json[extrasKey]),
        fow: json[fowKey]?[fowKey] == null
            ? []
            : (json[fowKey][fowKey] as List<dynamic>)
                  .map((e) => FOWModel.fromJson(e))
                  .toList(),
        pp: json[ppKey]?[powerplayKey] == null
            ? []
            : (json[ppKey][powerplayKey] as List<dynamic>)
                  .map((e) => PowerplayModel.fromJson(e))
                  .toList(),
        ps: json[partnershipKey]?[partnershipKey] == null
            ? []
            : (json[partnershipKey][partnershipKey] as List<dynamic>)
                  .map((e) => PartnershipModel.fromJson(e))
                  .toList(),
      );
}

class BatsmanModel {
  final int id;
  final int balls;
  final int runs;
  final int fours;
  final int six;
  final double strkrate;
  final String name;
  final bool isCaptain;
  final bool isKeeper;
  final String? outdec;
  final bool isOverseas;

  BatsmanModel({
    required this.id,
    required this.balls,
    required this.runs,
    required this.fours,
    required this.six,
    required this.strkrate,
    required this.name,
    required this.isCaptain,
    required this.isKeeper,
    this.outdec,
    required this.isOverseas,
  });

  factory BatsmanModel.fromJson(Map<String, dynamic> json) => BatsmanModel(
    id: json[idKey],
    balls: json[ballsKey],
    runs: json[runsKey],
    fours: json[foursKey],
    six: json[sixesKey],
    strkrate: double.parse(json[strkrateKey]),
    name: json[nameKey],
    isCaptain: json[iscaptainKey],
    isKeeper: json[iskeeperKey],
    outdec: json[outdecKey],
    isOverseas: json[isoverseasKey],
  );
}

class BowlerModel {
  final int id;
  final String name;
  final String nickname;
  final String overs;
  final int maidens;
  final int runs;
  final int wickets;
  final String economy;

  BowlerModel({
    required this.id,
    required this.name,
    required this.nickname,
    required this.overs,
    required this.maidens,
    required this.runs,
    required this.wickets,
    required this.economy,
  });
  factory BowlerModel.fromJson(Map<String, dynamic> json) => BowlerModel(
    id: json[idKey],
    name: json[nameKey],
    nickname: json[nicknameKey],
    overs: json[oversKey],
    maidens: json[maidensKey],
    runs: json[runsKey],
    wickets: json[wicketsKey],
    economy: json[economyKey],
  );
}

class ExtrasModel {
  final int legbyes;
  final int byes;
  final int wides;
  final int noballs;
  final int penalty;
  final int total;

  ExtrasModel({
    required this.legbyes,
    required this.byes,
    required this.wides,
    required this.noballs,
    required this.penalty,
    required this.total,
  });

  factory ExtrasModel.fromJson(Map<String, dynamic> json) => ExtrasModel(
    legbyes: json[legbyesKey],
    byes: json[byesKey],
    wides: json[widesKey],
    noballs: json[noballsKey],
    penalty: json[penaltyKey],
    total: json[totalKey],
  );
}

class FOWModel {
  final int batsmanId;
  final String batsmanName;
  final double overnbr;
  final int runs;

  FOWModel({
    required this.batsmanId,
    required this.batsmanName,
    required this.overnbr,
    required this.runs,
  });

  factory FOWModel.fromJson(Map<String, dynamic> json) => FOWModel(
    batsmanId: json[batsmanidKey],
    batsmanName: json[batsmannameKey],
    overnbr: json[overnbrKey],
    runs: json[runsKey],
  );
}

class PowerplayModel {
  final int id;
  final String ppType;
  final double overFrom;
  final double overTo;
  final int runs;
  final int wickets;

  PowerplayModel({
    required this.id,
    required this.ppType,
    required this.overFrom,
    required this.overTo,
    required this.runs,
    required this.wickets,
  });

  factory PowerplayModel.fromJson(Map<String, dynamic> json) => PowerplayModel(
    id: json[idKey],
    ppType: json[pptypeKey],
    overFrom: json[ovrfromKey],
    overTo: json[ovrtoKey],
    runs: json[runKey],
    wickets: json[wicketsKey],
  );
}

class PartnershipModel {
  final int id;
  final int bat1Id;
  final String bat1Name;
  final int bat1Runs;
  final int bat1Balls;
  final int bat2Id;
  final String bat2Name;
  final int bat2Runs;
  final int bat2Balls;
  final int totalRuns;
  final int totalBalls;

  PartnershipModel({
    required this.id,
    required this.bat1Id,
    required this.bat1Name,
    required this.bat1Runs,
    required this.bat1Balls,
    required this.bat2Id,
    required this.bat2Name,
    required this.bat2Runs,
    required this.bat2Balls,
    required this.totalBalls,
    required this.totalRuns,
  });

  factory PartnershipModel.fromJson(Map<String, dynamic> json) =>
      PartnershipModel(
        id: json[idKey],
        bat1Id: json[bat1idKey],
        bat1Name: json[bat1nameKey],
        bat1Runs: json[bat1runsKey],
        bat1Balls: json[bat1ballsKey],
        bat2Id: json[bat2idKey],
        bat2Name: json[bat2nameKey],
        bat2Runs: json[bat2runsKey],
        bat2Balls: json[bat2ballsKey],
        totalRuns: json[totalrunsKey],
        totalBalls: json[totalballsKey],
      );
}
