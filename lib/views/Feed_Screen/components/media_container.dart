import 'package:bitsapp/constants/size_config.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/views/feed_screen/components/image_container.dart';
import 'package:bitsapp/views/feed_screen/components/video_container.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MediaContainer extends StatelessWidget {
  const MediaContainer({super.key, required this.post});
  final FeedPost post;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      
      key: Key(post.timeuid),
      itemCount: post.mediaFilesList.length,
      options: CarouselOptions(
        enableInfiniteScroll: false,
        height: SizeConfig.screenWidth * 1,
        scrollDirection: Axis.horizontal,
        viewportFraction: 1,
      ),
      itemBuilder: (context, index, realIndex) {
        final mediaFile = post.mediaFilesList[index];
        if (mediaFile.type == 'image') {
          return SizedBox(
            
            width: SizeConfig.screenWidth,
            child: ImageContainer(url: mediaFile.url, tag: mediaFile.url),
          );
        } else {
          return VideoContainer(
            url: mediaFile.url,
            tag: mediaFile.url,
          );
        }
      },
    );
  }
}
