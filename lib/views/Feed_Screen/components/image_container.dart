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
    Navigator.push(
      
      context,
      PageRouteBuilder(
        
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => HeroContainer(tag: url),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = 0.0;
          var end = 1.0;
          var curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return ScaleTransition(
            scale: animation.drive(tween),
            child: child,
          );
        },
       opaque: false
      ),
    );
  },
      child: PhotoView(
        initialScale: PhotoViewComputedScale.covered,

        // wantKeepAlive: true,
        imageProvider: CachedNetworkImageProvider(
          url,
          cacheKey: url,
        ),
      ),
    );
  }
}
