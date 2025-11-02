import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class CustomNetworkImage extends StatelessWidget {
  final int imageId;
  final double height;
  final double width;
  final double radius;
  const CustomNetworkImage({
    super.key,
    required this.imageId,
    required this.height,
    required this.width,
    this.radius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return nb.PlaceHolderWidget(
      width: width,
      height: height,
      // child: CachedNetworkImage(
      //   imageUrl: "${Configs.baseURL}${getImageEp(imageId)}",
      //   httpHeaders: {
      //     "x-rapidapi-host": RemoteConfigs.xRapidapiHostRc,
      //     "x-rapidapi-key": RemoteConfigs.xRapidapiKeyRc,
      //   },
      //   fit: BoxFit.cover,
      //   errorWidget: (context, url, error) {
      //     nb.log("CustomNetworkImage: $error");
      //     return Icon(Icons.info_outline, color: Colors.grey, size: 20.w);
      //   },
      // ),
    ).cornerRadiusWithClipRRect(radius.r);
  }
}
