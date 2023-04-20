import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoContainer extends StatefulHookConsumerWidget {
  const VideoContainer({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  ConsumerState<VideoContainer> createState() => _VideoContainerState();
}

class _VideoContainerState extends ConsumerState<VideoContainer> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;

  bool init = true;
  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  void _initPlayer() async {
    final videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');

    await videoPlayerController.initialize();

    _chewieController =
        ChewieController(videoPlayerController: videoPlayerController);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null
        ? Chewie(controller: _chewieController!)
        : const CircularProgressIndicator(
            color: Colors.red,
          );
    // return FutureBuilder(
    //     future:
    //         DefaultCacheManager().getSingleFile(widget.url, key: widget.url),
    //     builder: (context, file) {
    //       if (file.connectionState == ConnectionState.done) {
    //         if (file.hasData) {
    //           if (init) {
    //             _controller = VideoPlayerController.file(file.data as File)
    //               ..initialize().then((_) {
    //                 {
    //                   setState(() {
    //                     dlog("file data is ${file.data}");
    //                     init = false;
    //                   });
    //                 }
    //               });
    //           }
    //           return GestureDetector(
    //             onTap: () {
    //               setState(() {
    //                 _controller.value.isPlaying
    //                     ? _controller.pause()
    //                     : _controller.play();
    //               });
    //             },
    //             child: SizedBox(
    //               child: VideoPlayer(_controller),
    //             ),
    //           );
    //         } else {
    //           return const CircularProgressIndicator();
    //         }
    //       } else {
    //         return const CircularProgressIndicator(
    //           color: Colors.red,
    //         );
    //       }
    //     });
  }
}
