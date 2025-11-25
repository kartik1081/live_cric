import 'package:live_cric/utils/const.dart';

class CrtPlayerInfoModel {
  final String id;
  final String bat;
  final String bowl;
  final String name;
  final String role;
  final String birthPlace;
  final String intlTeam;
  final String teams;
  final String dob;
  final int faceImageId;
  final String bio;

  CrtPlayerInfoModel({
    required this.id,
    required this.bat,
    required this.bowl,
    required this.name,
    required this.role,
    required this.birthPlace,
    required this.intlTeam,
    required this.teams,
    required this.dob,
    required this.faceImageId,
    required this.bio,
  });

  factory CrtPlayerInfoModel.fromJson(Map<String, dynamic> json) =>
      CrtPlayerInfoModel(
        id: json[idKey],
        bat: json[batKey],
        bowl: json[bowlKey],
        name: json[nameKey],
        role: json[roleKey],
        birthPlace: json[birthPlaceKey],
        intlTeam: json[intlTeamKey],
        teams: json[teamsKey],
        dob: json[dobKey],
        faceImageId: json[faceImageIdKey],
        bio: json[bioKey],
      );
}
