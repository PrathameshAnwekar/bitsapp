import 'dart:io';

import 'package:bitsapp/services/logger_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

/// Stateful widget to fetch and then display video content.
class LocalVideoContainer extends StatefulHookConsumerWidget {
  const LocalVideoContainer({Key? key, required this.file}) : super(key: key);
  final File file;
  @override
  _LocalVideoContainerState createState() => _LocalVideoContainerState();
}

class _LocalVideoContainerState extends ConsumerState<LocalVideoContainer> {
  late VideoPlayerController _controller;

  bool init = true;

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.file(widget.file)..initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (init) {
      setState(() {
        init = false;
      });
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          _controller.value.isPlaying
              ? _controller.pause()
              : _controller.play();
        });
      },
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
