import 'package:bitsapp/views/feed_screen/components/hero_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Scaffold(
              backgroundColor: Colors.transparent,
              body: PhotoView(
                imageProvider: CachedNetworkImageProvider(url),
                heroAttributes: PhotoViewHeroAttributes(
                  tag: url,
                ),
              ),
            ),
          ),
        );
      },
      child: Hero(
        tag: url,
        child: CachedNetworkImage(
          imageUrl: url,
          cacheKey: url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
