import 'package:intl/intl.dart';
import 'package:live_cric/utils/const.dart';

class CrtMatchInfoModel {
  final int matchId;
  final int seriesId;
  final String seriesName;
  final String matchDesc;
  final String format;
  final String startedAtDate;
  final String startedAtTime;
  final String tossStatus;
  final String venue;
  final UARModel? umpire1;
  final UARModel? umpire2;
  final UARModel? umpire3;
  final UARModel? referee;

  CrtMatchInfoModel({
    required this.matchId,
    required this.seriesId,
    required this.seriesName,
    required this.matchDesc,
    required this.format,
    required this.startedAtDate,
    required this.startedAtTime,
    required this.tossStatus,
    required this.venue,
    this.umpire1,
    this.umpire2,
    this.umpire3,
    this.referee,
  });

  factory CrtMatchInfoModel.fromJson(Map<String, dynamic> json) =>
      CrtMatchInfoModel(
        matchId: json[matchidKey],
        seriesId: json[seriesidKey],
        seriesName: json[seriesnameKey],
        matchDesc: json[matchdescKey],
        format: json[matchformatKey],
        startedAtDate: DateFormat("EEE, MMM dd").format(
          DateTime.fromMillisecondsSinceEpoch(
            (json[startdateKey] as int),
          ).toLocal(),
        ),
        startedAtTime: DateFormat("h:mm a").format(
          DateTime.fromMillisecondsSinceEpoch(
            (json[startdateKey] as int),
          ).toLocal(),
        ),
        tossStatus: json[tossstatusKey],
        venue:
            "${json[venueinfoKey][groundKey]}, ${json[venueinfoKey][cityKey]}",
        umpire1: json[umpire1Key] == null
            ? null
            : UARModel.fromJson(json[umpire1Key]),
        umpire2: json[umpire2Key] == null
            ? null
            : UARModel.fromJson(json[umpire2Key]),
        umpire3: json[umpire3Key] == null
            ? null
            : UARModel.fromJson(json[umpire3Key]),
        referee: json[refereeKey] == null
            ? null
            : UARModel.fromJson(json[refereeKey]),
      );
}

class UARModel {
  final int id;
  final String name;
  final String country;

  UARModel({required this.id, required this.name, required this.country});

  factory UARModel.fromJson(Map<String, dynamic> json) =>
      UARModel(id: json[idKey], name: json[nameKey], country: json[countryKey]);
}
