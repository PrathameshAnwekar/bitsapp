import 'package:bitsapp/views/Feed_Screen/components/feed_description.dart';
import 'package:flutter/material.dart';

import '../Feed_Detail_Screen/feed_detail_screen.dart';

class FeedContainer extends StatelessWidget {
  const FeedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              const FeedDetailScreen(isCommentPressed: false))),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(1),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: FeedDesc(
          isFeedScreen: true,
          commentFunc: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  const FeedDetailScreen(isCommentPressed: true),
            ),
          ),
        ),
      ),
    );
  }
}
