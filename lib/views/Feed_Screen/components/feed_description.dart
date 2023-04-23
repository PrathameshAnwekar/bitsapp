import 'package:bitsapp/controllers/feed_container_controller.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/storage/hiveStore.dart';
import 'package:bitsapp/views/components/person_detail.dart';
import 'package:bitsapp/views/feed_screen/Feed_Detail_Screen/feed_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readmore/readmore.dart';

import '../../../constants/constants.dart';
import '../../components/circle_profile_pic.dart';
import 'media_container.dart';

class FeedDesc extends HookConsumerWidget {
  final bool isFeedScreen;
  final Function commentFunc;
  final FeedPost feedPost;
  const FeedDesc({
    super.key,
    required this.isFeedScreen,
    required this.commentFunc,
    required this.feedPost,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poster = HiveStore.getUserFromStorage(uid: feedPost.posterUid) ?? BitsUser.dummy;
    // final poster = ref
    //     .read(contactsListProvider)
    //     .firstWhere((element) => element.uid == feedPost.posterUid);
    final localUser = ref.watch(localUserProvider);
    final likeStatus = useState(feedPost.likes.contains(localUser.uid));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: ReadMoreText(
              feedPost.text,
              style: GoogleFonts.roboto(fontSize: 14.5),
              moreStyle: GoogleFonts.firaSans(color: const Color(0xFF0073B1)),
              lessStyle: GoogleFonts.firaSans(color: const Color(0xFF0073B1)),
              textAlign: TextAlign.start,
              trimCollapsedText: " more",
              trimExpandedText: " less",
              trimMode: isFeedScreen ? TrimMode.Length : TrimMode.Line,
              trimLines: 100000,
              trimLength: 240,
            ),
          ),
        ),
        MediaContainer(post: feedPost),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  await FeedContainerController.toggleLike(
                      likeStatus: likeStatus,
                      localUserUid: localUser.uid,
                      feedPostUid: feedPost.timeuid,
                      ref: ref);
                },
                child: SvgPicture.asset(
                  likeStatus.value
                      ? Constants.postOptionIcons[1]
                      : Constants.postOptionIcons[0],
                  width: 25,
                  height: 25,
                  color: !likeStatus.value
                      ? const Color.fromRGBO(32, 33, 37, 1)
                      : Constants.activeIconColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, right: 12),
                child: Text(
                  '123',
                  style: GoogleFonts.manrope(color: Colors.black87),
                ),
              ),
              GestureDetector(
                onTap: () => commentFunc(),
                child: SvgPicture.asset(
                  Constants.postOptionIcons[2],
                  width: 25,
                  height: 25,
                  color: const Color.fromRGBO(32, 33, 37, 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                  '16',
                  style: GoogleFonts.manrope(color: Colors.black87),
                ),
              ),
              const Spacer(),
              // GestureDetector(
              //   onTap: () async {
              //     final res =
              //         await FeedContainerController.bookmarkFeedPost(feedPost);

              //     if (res) {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(
              //           content: Text('Post Bookmarked'),
              //           duration: Duration(seconds: 1),
              //         ),
              //       );
              //     }
              //   },
              //   child: SvgPicture.asset(
              //     Constants.postOptionIcons[2],
              //     width: 26,
              //     height: 26,
              //     color: const Color(0xFF0073B1),
              //   ),
              // ),
              GestureDetector(
                onTap: () async {
                  await FeedContainerController.openShareSheet(
                      context, feedPost);
                },
                child: SvgPicture.asset(
                  Constants.postOptionIcons[4],
                  width: 25,
                  height: 25,
                  color: const Color.fromRGBO(32, 33, 37, 1),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz_rounded,
                  color: Color.fromRGBO(32, 33, 37, 1),
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
