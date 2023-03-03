import 'dart:io';

import 'package:bitsapp/services/logger_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

/// Stateful widget to fetch and then display video content.
class VideoContainer extends StatefulHookConsumerWidget {
  const VideoContainer({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  _VideoContainerState createState() => _VideoContainerState();
}

class _VideoContainerState extends ConsumerState<VideoContainer> {
  late VideoPlayerController _controller;

  bool init = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            DefaultCacheManager().getSingleFile(widget.url, key: widget.url),
        builder: (context, file) {
          if (file.connectionState == ConnectionState.done) {
            if (file.hasData) {
             if (init) {
               _controller = VideoPlayerController.file(file.data as File)
                ..initialize().then((_) {
                  {
                    setState(() {
                      dlog("file data is ${file.data}");
                      init = false;
                    });
                  }
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
            } else {
              return const CircularProgressIndicator();
            }
          } else {
            return const CircularProgressIndicator(
              color: Colors.red,
            );
          }
        });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
