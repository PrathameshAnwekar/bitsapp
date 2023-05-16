import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/constants/size_config.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/storage/hiveStore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:readmore/readmore.dart';

import '../../Components/person_detail.dart';
import '../../components/circle_profile_pic.dart';
import '../../feed_screen/Feed_Detail_Screen/feed_detail_screen.dart';
import '../../feed_screen/components/media_container.dart';
import '../../profile_screen/profile_screen.dart';

class ChatPostContainer extends ConsumerStatefulWidget {
  final Message message;
  final bool isSender;
  const ChatPostContainer({
    required super.key,
    required this.isSender,
    required this.message,
  });
  @override
  ChatPostContainerState createState() {
    return ChatPostContainerState();
  }
}

class ChatPostContainerState extends ConsumerState<ChatPostContainer>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // This line is important
    final postUid = widget.message.text.substring(
        25,
        widget.message.text
            .length); // 25 is the length of the string "InternalPostShare@"
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("FeedPosts")
          .doc(postUid)
          .get(const GetOptions(source: Source.serverAndCache)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: SizeConfig.screenHeight * 0.4,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          final feedPost = FeedPost.fromJson(snapshot.data!.data()!);
          // feedPost.mediaFilesList = [feedPost.mediaFilesList[0]];
          final mediaFile = [feedPost.mediaFilesList[0]];
          final BitsUser poster =
              HiveStore.getUserFromStorage(uid: feedPost.posterUid) ??
                  BitsUser.dummy;
          return Container(
            padding: const EdgeInsets.only(top: 10),
            margin: EdgeInsets.only(
              left: widget.isSender ? 20 : 0,
              right: widget.isSender ? 0 : 20,
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
                bottomLeft: Radius.circular(widget.isSender ? 10 : 0),
                bottomRight: Radius.circular(widget.isSender ? 0 : 10),
              ),
              border: Border.all(color: Colors.grey.shade200, width: 0.6),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: ProfileScreen(poster),
                        duration: const Duration(milliseconds: 250),
                      ),
                    ),
                    child: Row(
                      children: [
                        const CircleProfilePic(radius: 22.5),
                        const SizedBox(width: 10),
                        PersonDetail(
                          user: poster,
                          isSmall: false,
                          time: int.tryParse(feedPost.timeuid),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FeedDetailScreen(
                          isCommentPressed: false,
                          feedPost: feedPost,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: ReadMoreText(
                      feedPost.text,
                      style: GoogleFonts.roboto(fontSize: 14.5),
                      moreStyle:
                          GoogleFonts.firaSans(color: Constants.kPrimaryColor),
                      lessStyle:
                          GoogleFonts.firaSans(color: Constants.kPrimaryColor),
                      textAlign: TextAlign.start,
                      trimCollapsedText: " more",
                      trimExpandedText: " less",
                      trimMode: TrimMode.Line,
                      trimLines: 2,
                    ),
                  ),
                ),
                MediaContainer(
                  timeuid: feedPost.timeuid,
                  mediaFilesList: mediaFile,
                  heightFactor: 0.7,
                ),
              ],
            ),
          );
        } else {
          return Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: const Text(
              "Post Not Available",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
