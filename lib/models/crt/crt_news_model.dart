import 'package:intl/intl.dart';
import 'package:live_cric/utils/const.dart';

class CrtNewsModel {
  final int id;
  final String hLine;
  final String intro;
  final String pubTime;
  final String source;
  final String storyType;
  final String seoHeadline;
  final int imageId;
  final String context;

  CrtNewsModel({
    required this.id,
    required this.hLine,
    required this.intro,
    required this.pubTime,
    required this.source,
    required this.storyType,
    required this.seoHeadline,
    required this.imageId,
    required this.context,
  });

  factory CrtNewsModel.fromJson(Map<String, dynamic> json) => CrtNewsModel(
    id: json[idKey],
    hLine: json[hLineKey],
    intro: json[introKey],
    pubTime: DateFormat("h:mm a").format(
      DateTime.fromMillisecondsSinceEpoch(
        int.parse(json[pubTimeKey] as String),
      ).toLocal(),
    ),
    source: json[sourceKey],
    storyType: json[storyTypeKey],
    seoHeadline: json[seoHeadlineKey],
    imageId: json[imageIdKey],
    context: json[contextKey],
  );
}
