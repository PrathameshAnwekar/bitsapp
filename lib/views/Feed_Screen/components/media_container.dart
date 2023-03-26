import 'package:bitsapp/constants/size_config.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:bitsapp/views/Feed_Screen/components/image_container.dart';
import 'package:bitsapp/views/Feed_Screen/components/video_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MediaContainer extends StatelessWidget {
  const MediaContainer({super.key, required this.post});
  final FeedPost post;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenWidth * 1,
      child: ListView.builder(
        physics:const PageScrollPhysics(),
        cacheExtent: 1000,
       
        scrollDirection: Axis.horizontal,
        itemCount: post.mediaFilesList.length,
        itemBuilder: (context, index) {
          final mediaFile = post.mediaFilesList[index];
          if (mediaFile.type == 'image') {
            return SizedBox(
              width: SizeConfig.screenWidth * 1,
              child: ImageContainer(
                url: mediaFile.url,
              ),
            );
          } else {
            return SizedBox(
                width: SizeConfig.screenWidth * 1,
                child: VideoContainer(url: mediaFile.url));
          }
        },
      ),
    );
  }
}
