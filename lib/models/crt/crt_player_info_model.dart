import 'package:live_cric/utils/const.dart';

class CrtPlayerInfoModel {
  final String id;
  final String bat;
  final String bowl;
  final String name;
  final String nickName;
  final String role;
  final String birthPlace;
  final String intlTeam;
  final String teams;
  final String dob;
  final int faceImageId;
  final int intlTeamImageId;
  final String bio;
  final List<dynamic> recentBatting;
  final List<dynamic> recentBowling;

  CrtPlayerInfoModel({
    required this.id,
    required this.bat,
    required this.bowl,
    required this.name,
    required this.nickName,
    required this.role,
    required this.birthPlace,
    required this.intlTeam,
    required this.teams,
    required this.dob,
    required this.faceImageId,
    required this.intlTeamImageId,
    required this.bio,
    required this.recentBatting,
    required this.recentBowling,
  });

  factory CrtPlayerInfoModel.fromJson(Map<String, dynamic> json) =>
      CrtPlayerInfoModel(
        id: json[idKey],
        bat: json[batKey] ?? "N/A",
        bowl: json[bowlKey] ?? "N/A",
        name: json[nameKey] ?? "N/A",
        nickName: json[nickNameKey] ?? json[nameKey],
        role: json[roleKey] ?? "N/A",
        birthPlace: json[birthPlaceKey] ?? "N/A",
        intlTeam: json[intlTeamKey] ?? "N/A",
        teams: json[teamsKey] ?? "N/A",
        dob: json[dobKey] ?? "N/A",
        faceImageId: json[faceImageIdKey] ?? "-1",
        intlTeamImageId: json[intlTeamImageIdKey] ?? "-1",
        bio: json[bioKey] ?? "N/A",
        recentBatting: (json[recentBattingKey][rowsKey] as List<dynamic>)
            .map((e) => (e[valuesKey] as List<dynamic>).sublist(1, 5))
            .toList(),
        recentBowling: (json[recentBowlingKey][rowsKey] as List<dynamic>)
            .map((e) => (e[valuesKey] as List<dynamic>).sublist(1, 5))
            .toList(),
      );
}
