import 'package:bitsapp/constants/size_config.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/views/feed_screen/components/new_video_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

import '../../Feed_Screen/components/image_container.dart';

class MediaContainer extends StatelessWidget {
  const MediaContainer({super.key, required this.post});
  final FeedPost post;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: post.mediaFilesList.length,
      options: CarouselOptions(
        enableInfiniteScroll: false,
        height: SizeConfig.screenWidth * 1.1,
        scrollDirection: Axis.horizontal,
        viewportFraction: 1,
      ),
      itemBuilder: (context, index, realIndex) {
        final mediaFile = post.mediaFilesList[index];
        if (mediaFile.type == 'image') {
          return SizedBox(
            width: SizeConfig.screenWidth,
            child: ImageContainer(url: mediaFile.url),
          );
        } else {
          return ChewieListItem(
            videoPlayerController: VideoPlayerController.network(mediaFile.url),
          );
        }
      },
    );
  }
}
