import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/views/feed_screen/components/comment_box.dart';
import 'package:flutter/material.dart';

import '../components/feed_description.dart';

class FeedDetailScreen extends StatefulWidget {
  final bool isCommentPressed;
  final FeedPost feedPost;
  const FeedDetailScreen({super.key, required this.isCommentPressed,required this.feedPost});

  @override
  State<FeedDetailScreen> createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends State<FeedDetailScreen> {
  final _itemKey = GlobalKey();
  void commentFunc() async {
    final context = _itemKey.currentContext!;
    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void initState() {
    if (widget.isCommentPressed) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => Future.delayed(const Duration(milliseconds: 280), commentFunc),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FeedDesc(
                  isFeedScreen: false,
                  commentFunc: commentFunc,
                  feedPost: widget.feedPost,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    key: _itemKey,
                    "Comments",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 2000,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) => const CommentBox(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
