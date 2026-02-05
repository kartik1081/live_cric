import 'package:live_cric/utils/extensions/flavor_ext.dart';
import 'package:live_cric/utils/flaove_config.dart';

class AdModel {
  final bool show;
  final String adId;

  AdModel({required this.show, required this.adId});

  factory AdModel.fromJson(Map<String, dynamic> json) =>
      FlavorConfig.flavor.getAdIds(json);
}
