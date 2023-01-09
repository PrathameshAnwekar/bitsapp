import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'progress_bar.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;
  const VideoPlayerWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ? Container(
            child: buildVideo(),
          )
        : const CircularProgressIndicator();
  }

  Widget buildVideo() => Stack(children: <Widget>[
        buildVidePlayer(),
        Positioned.fill(child: BasicOverlayWidget(controller: controller))
      ]);
  Widget buildVidePlayer() {
    return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller));
  }
}
