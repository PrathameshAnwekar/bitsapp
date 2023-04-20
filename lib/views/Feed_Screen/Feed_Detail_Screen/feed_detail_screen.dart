import 'package:bitsapp/controllers/feed_container_controller.dart';
import 'package:bitsapp/models/comment.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/views/feed_screen/components/comment_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/feed_description.dart';

class FeedDetailScreen extends ConsumerStatefulWidget {
  final bool isCommentPressed;
  final FeedPost feedPost;
  const FeedDetailScreen(
      {super.key, required this.isCommentPressed, required this.feedPost});

  @override
  ConsumerState<FeedDetailScreen> createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends ConsumerState<FeedDetailScreen> {
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
    commentController = TextEditingController();
    if (widget.isCommentPressed) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => Future.delayed(const Duration(milliseconds: 280), commentFunc),
      );
    }
    super.initState();
  }

  late final TextEditingController commentController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 60),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  child: Text(
                    key: _itemKey,
                    "Comments",
                    style: GoogleFonts.firaSans(
                      fontSize: 17.5,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.feedPost.comments.length,
                    itemBuilder: (context, index) =>  CommentsBox(comment: widget.feedPost.comments[index]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: TextFormField(
        controller: commentController,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (value) {
          FeedContainerController.addCommentToPost(
              feedPost: widget.feedPost,
              commentController: commentController,
              ref: ref);
        },
        style: GoogleFonts.firaSans(
          color: Colors.white,
          fontSize: 17,
        ),
        cursorColor: const Color(0xFF0073B1),
        decoration: InputDecoration(
          hintText: "Add a comment",
          hintStyle: GoogleFonts.firaSans(
            color: Colors.white,
            fontSize: 17,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 30, 30, 31),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
        ),
      ),

      // bottomNavigationBar: Padding(
      //   padding: MediaQuery.of(context).viewInsets,
      //   child: TextFormField(
      //     style: GoogleFonts.firaSans(
      //       color: Colors.white,
      //       fontSize: 17,
      //     ),
      //     cursorColor: const Color(0xFF0073B1),
      //     decoration: InputDecoration(
      //       hintText: "Add a comment",
      //       hintStyle: GoogleFonts.firaSans(
      //         color: Colors.white,
      //         fontSize: 17,
      //       ),
      //       border: const OutlineInputBorder(
      //         borderRadius: BorderRadius.only(
      //             topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      //         borderSide: BorderSide.none,
      //       ),
      //       filled: true,
      //       fillColor: const Color.fromARGB(255, 30, 30, 31),
      //       contentPadding:
      //           const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
      //     ),
      //   ),
      // ),
    );
  }
}
