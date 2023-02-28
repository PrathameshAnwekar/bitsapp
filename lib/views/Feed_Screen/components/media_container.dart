import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/views/Feed_Screen/components/image_container.dart';
import 'package:bitsapp/views/Feed_Screen/components/video_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MediaContainer extends StatelessWidget {
  const MediaContainer({super.key, required this.post});
  final FeedPost post;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        cacheExtent: 1000,
        scrollDirection: Axis.horizontal,
        itemCount: post.mediaFilesList.length,
        itemBuilder: (context, index) {
          final mediaFile = post.mediaFilesList[index];
          if(mediaFile.type == 'image') {
            return ImageContainer(url: mediaFile.url,);
          } else
            return VideoContainer(url: mediaFile.url);
    
        },
      ),
    );
  }
}
