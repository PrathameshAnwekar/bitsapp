import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/views/feed_screen/components/feed_description.dart';
import 'package:flutter/material.dart';

import '../Feed_Detail_Screen/feed_detail_screen.dart';

class FeedContainer extends StatelessWidget {
  const FeedContainer({super.key,required this.feedPost});
  final FeedPost feedPost;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
               FeedDetailScreen(isCommentPressed: false, feedPost: feedPost))),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(1),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          children: [
            FeedDesc(
              isFeedScreen: true,
              feedPost: feedPost,
              commentFunc: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                       FeedDetailScreen(isCommentPressed: true, feedPost: feedPost,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
