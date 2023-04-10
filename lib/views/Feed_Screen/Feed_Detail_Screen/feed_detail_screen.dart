import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/views/feed_screen/components/comment_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/feed_description.dart';

class FeedDetailScreen extends StatefulWidget {
  final bool isCommentPressed;
  final FeedPost feedPost;
  const FeedDetailScreen(
      {super.key, required this.isCommentPressed, required this.feedPost});

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
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 60),
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
                    style: GoogleFonts.firaSans(
                      fontSize: 17.5,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => const CommentsBox(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: TextFormField(
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
