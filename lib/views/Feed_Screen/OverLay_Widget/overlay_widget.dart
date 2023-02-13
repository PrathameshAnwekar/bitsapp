import 'dart:ui';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:bitsapp/views/Feed_Screen/OverLay_Widget/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

import 'loader.dart';

class OverlayImage extends StatelessWidget {
  const OverlayImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: Loader.appLoader.loaderShowingNotifier,
      builder: (context, value, child) {
        if (value) {
          return ValueListenableBuilder<bool>(
            valueListenable: Loader.appLoader.loaderIsImageOrVideo,
            builder: (context, value, child) {
              if (value) {
                return OpacityAnimatedWidget(
                  curve: Curves.linear,
                  duration: const Duration(milliseconds: 250),
                  enabled: value,
                  child: GestureDetector(
                      onTap: () => Loader.appLoader.hideLoader(),
                      child: imageWidget(context)),
                );
              } else {
                return OpacityAnimatedWidget(
                  curve: Curves.linear,
                  duration: const Duration(milliseconds: 250),
                  enabled: value,
                  child: GestureDetector(
                      onTap: () => Loader.appLoader.hideLoader(),
                      child: videoWidget(context)),
                );
              }
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget imageWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
        Center(
          child: ValueListenableBuilder<String>(
            builder: (context, value, child) {
              return Hero(
                transitionOnUserGestures: true,
                tag: value,
                child: PhotoView(
                  backgroundDecoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.4)),
                  imageProvider: NetworkImage(value),
                  minScale: PhotoViewComputedScale.contained * 0.85,
                  maxScale: PhotoViewComputedScale.covered * 2,
                ),
              );
            },
            valueListenable: Loader.appLoader.loaderImageURLNotifier,
          ),
        ),
      ],
    );
  }

  Widget videoWidget(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
        Center(
          child: ValueListenableBuilder<VideoPlayerController>(
            builder: (context, value, child) {
              return VideoPlayerWidget(controller: value);
            },
            valueListenable: Loader.appLoader.loaderVideoControllerNotifier,
          ),
        ),
      ],
    );
  }
}
