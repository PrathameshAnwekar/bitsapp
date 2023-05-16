import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  ImageContainer({super.key, required this.url, required this.tag, this.isHero = false});
  final String url;
  final String tag;
  bool isHero;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
     if(!isHero)   Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => ImageContainer(url: url, tag: tag, isHero: true,)
          ),
        );
      },
      child: Hero(
        createRectTween: (begin, end) {
          return RectTween(begin: begin, end: end);
        },
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
