import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class HeroContainer extends StatefulWidget {
  final String tag;

  const HeroContainer({Key? key, required this.tag}) : super(key: key);

  @override
  _HeroContainerState createState() => _HeroContainerState();
}

class _HeroContainerState extends State<HeroContainer> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        opacity: opacity,
        duration: Duration(milliseconds: 500),
        child: PhotoView(
          heroAttributes: PhotoViewHeroAttributes(tag: widget.tag),
          imageProvider: CachedNetworkImageProvider(
            widget.tag,
            cacheKey: widget.tag,
          ),
        ),
      ),
    );
  }
}
