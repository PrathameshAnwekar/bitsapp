import 'package:bitsapp/constants/size_config.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return ZoomOverlay(
       modalBarrierColor: Colors.black12, // optional
            minScale: 0.5, // optional
            maxScale: 3.0, // optional
            twoTouchOnly: true,
            animationDuration: const Duration(milliseconds: 300),
            animationCurve: Curves.fastOutSlowIn,
      child: SizedBox(
        height: SizeConfig.screenHeight * 0.45,
        child: Image(
          image: CachedNetworkImageProvider(
            url,
            cacheKey: url,
            errorListener: () {
              dlog("error loading image");
            },
          ),
          fit: BoxFit.cover,
        ),
      ),
    );

    // return SizedBox(
    //   width: 300,
    //   child: PhotoView(
    //     imageProvider: CachedNetworkImageProvider(
    //       url,
    //       cacheKey: url,
    //       maxWidth: 300,
    //       errorListener: () {
    //         dlog("error loading image");
    //       },
    //     ),
    //   ),
    // );
  }
}
