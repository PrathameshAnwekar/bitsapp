import 'package:bitsapp/views/Feed_Screen/New_UI/comment_box.dart';
import 'package:flutter/material.dart';

import 'feed_description.dart';

class FeedDetailScreen extends StatefulWidget {
  final bool isCommentPressed;
  const FeedDetailScreen({super.key, required this.isCommentPressed});

  @override
  State<FeedDetailScreen> createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends State<FeedDetailScreen> {
  final itemKey = GlobalKey();
  void func() async {
    final context = itemKey.currentContext!;
    await Scrollable.ensureVisible(context,
        duration: const Duration(milliseconds: 800));
  }

  @override
  void initState() {
    if (widget.isCommentPressed) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => Future.delayed(const Duration(milliseconds: 280), func));
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
                // Container(
                //   margin: const EdgeInsets.only(top: 35, bottom: 5),
                //   height: 50,
                //   child: IconButton(
                //     onPressed: () => Navigator.of(context).pop(),
                //     icon: const Icon(
                //       Icons.arrow_back_ios_new_rounded,
                //       color: Colors.black54,
                //       size: 24,
                //     ),
                //   ),
                // ),
                FeedDesc(itemKey: itemKey, isFeedScreen: false),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    key: itemKey,
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
