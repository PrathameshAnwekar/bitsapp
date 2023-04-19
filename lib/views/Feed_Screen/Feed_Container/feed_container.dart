import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/views/feed_screen/components/feed_description.dart';
import 'package:flutter/material.dart';

import '../Feed_Detail_Screen/feed_detail_screen.dart';

class FeedContainer extends StatelessWidget {
  const FeedContainer({super.key, required this.feedPost});
  final FeedPost feedPost;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: FeedDesc(
        isFeedScreen: true,
        feedPost: feedPost,
        commentFunc: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FeedDetailScreen(
              isCommentPressed: true,
              feedPost: feedPost,
            ),
          ),
        ),
      ),
    );
  }
}
