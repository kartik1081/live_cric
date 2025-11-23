import 'package:live_cric/utils/const.dart';

class CrtTeamPlayerModel {
  final String id;
  final String name;
  final int imageId;
  final String battingStyle;
  final String bowlingStyle;

  CrtTeamPlayerModel({
    required this.id,
    required this.name,
    required this.imageId,
    required this.battingStyle,
    required this.bowlingStyle,
  });

  factory CrtTeamPlayerModel.fromJson(Map<String, dynamic> json) =>
      CrtTeamPlayerModel(
        id: json[idKey],
        name: json[nameKey],
        imageId: json[imageIdKey],
        battingStyle: json[battingStyleKey] ?? "",
        bowlingStyle: json[bowlingStyleKey] ?? "",
      );
}
