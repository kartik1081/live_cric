import 'package:live_cric/utils/const.dart';

class CrtTeamModel {
  final int teamId;
  final String teamName;
  final String teamSName;
  final int imageId;
  final String countryName;

  CrtTeamModel({
    required this.teamId,
    required this.teamName,
    required this.teamSName,
    required this.imageId,
    required this.countryName,
  });

  factory CrtTeamModel.fromJson(Map<String, dynamic> json) => CrtTeamModel(
    teamId: json[teamIdKey],
    teamName: json[teamNameKey],
    teamSName: json[teamShortNameKeY],
    imageId: json[imageIdKey],
    countryName: json[countryNameKey] ?? json[teamNameKey],
  );
}
