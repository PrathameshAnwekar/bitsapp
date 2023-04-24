import 'package:bitsapp/constants/size_config.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoContainer extends StatefulHookConsumerWidget {
  const VideoContainer({Key? key, required this.tag, required this.url})
      : super(key: key);
  final String url;
  final String tag;
  @override
  ConsumerState<VideoContainer> createState() => _VideoContainerState();
}

class _VideoContainerState extends ConsumerState<VideoContainer> {
  late ChewieController _chewieController =
      ChewieController(videoPlayerController: _controller);
  late VideoPlayerController _controller = VideoPlayerController.network(
      widget.url,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));

  bool init = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            DefaultCacheManager().getSingleFile(widget.url, key: widget.url),
        builder: (context, file) {
          if (file.connectionState == ConnectionState.done) {
            if (file.hasData) {
              if (init) {
                _controller = VideoPlayerController.file(file.data as File,
                    videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
                  ..initialize().then((_) {
                    {
                      setState(() {
                        dlog("file data is ${file.data}");
                        init = false;
                        _controller.setVolume(0);

                        _chewieController = ChewieController(
                            videoPlayerController: _controller,
                            autoPlay: true,
                            looping: true,
                            allowFullScreen: true,
                            allowMuting: true);
                      });
                    }
                  });
              }
              return Hero(
                tag: widget.tag,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _chewieController.isPlaying
                          ? _chewieController.pause()
                          : _chewieController.play();
                    });
                  },
                  child: Container(
                      width: SizeConfig.screenWidth,
                      color: Colors.black,
                      child: Chewie(controller: _chewieController)),
                ),
              );
            } else {
              return const CircularProgressIndicator(
                color: Colors.white,
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
        });
  }
}
