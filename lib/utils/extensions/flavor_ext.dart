import 'package:live_cric/models/ad_model.dart';
import 'package:live_cric/utils/const.dart';
import 'package:live_cric/utils/flaove_config.dart';

extension FlavorExt on FlavorEnum {
  AdModel getAdIds(Map<String, dynamic> json) {
    switch (this) {
      case FlavorEnum.prod:
        return AdModel(show: json[showKey], adId: json[adIdKey]);
      default:
        return AdModel(show: true, adId: json[adIdDevKey]);
    }
  }
}
