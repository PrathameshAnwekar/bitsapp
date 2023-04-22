import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return PinchZoom(
      resetDuration: const Duration(milliseconds: 300),
      child: CachedNetworkImage(
        imageUrl: url,
        cacheKey: url,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
