import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key, required this.url, required this.tag});
  final String url;
  final String tag;
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
                  tag: tag,
                ),
              ),
            ),
          ),
        );
      },
      child: Hero(
        tag: tag,
        child: CachedNetworkImage(
          imageUrl: url,
          cacheKey: url,
          fit: BoxFit.cover,
          repeat: ImageRepeat.noRepeat,
        ),
      ),
    );
  }
}
