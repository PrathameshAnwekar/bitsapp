import 'package:bitsapp/services/logger_service.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoContainer extends StatefulHookConsumerWidget {
  const VideoContainer({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  ConsumerState<VideoContainer> createState() => _VideoContainerState();
}

//TODO: Fix this, cache for chewie
class _VideoContainerState extends ConsumerState<VideoContainer> {
  ChewieController? _chewieController;
  VideoPlayerController? _controller;

  bool init = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController?.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return _chewieController != null
    //     ? Chewie(controller: _chewieController!)
    //     : const CircularProgressIndicator(
    //         color: Colors.red,
    //       );
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
                          _chewieController = ChewieController(videoPlayerController: _controller!);
                      });
                    }
                  });
              
              }
              return GestureDetector(
                // onTap: () {
                //   setState(() {
                //     _chewieController.value.isPlaying
                //         ? _chewieController.pause()
                //         : _chewieController.play();
                //   });
                // },
                child: SizedBox(
                  child: Chewie(controller: _chewieController!),
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
}
