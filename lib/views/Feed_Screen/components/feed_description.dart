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
import 'package:like_button/like_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:readmore/readmore.dart';

import '../../../constants/constants.dart';
import '../../components/circle_profile_pic.dart';
import '../../profile_screen/profile_screen.dart';
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
    final poster =
        HiveStore.getUserFromStorage(uid: feedPost.posterUid) ?? BitsUser.dummy;
    final localUser = ref.watch(localUserProvider);
    final likeStatus = useState(feedPost.likes.contains(localUser.uid));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
        MediaContainer(
          heightFactor: 1,
          timeuid: feedPost.timeuid,
          mediaFilesList: feedPost.mediaFilesList,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              LikeButton(
                isLiked: likeStatus.value,
                onTap: (isLiked) async {
                  return await FeedContainerController.toggleLike(
                    likeStatus: likeStatus,
                    localUserUid: localUser.uid,
                    feedPostUid: feedPost.timeuid,
                    ref: ref,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, right: 12),
                child: Text(
                  feedPost.likes.length.toString(),
                  style: GoogleFonts.manrope(color: Colors.black87),
                ),
              ),
              GestureDetector(
                onTap: () => commentFunc(),
                child: SvgPicture.asset(
                  Constants.postOptionIcons[2],
                  width: 25,
                  height: 25,
                  color: Constants.postOptionIconColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                  feedPost.comments.length.toString(),
                  style: GoogleFonts.manrope(color: Colors.black87),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  await FeedContainerController.openShareSheet(
                    context,
                    feedPost,
                  );
                },
                child: SvgPicture.asset(
                  Constants.postOptionIcons[4],
                  width: 25,
                  height: 25,
                  color: Constants.postOptionIconColor,
                ),
              ),
              PopupMenuButton(
                color: Constants.kSecondaryColor,
                elevation: 0,
                onSelected: (value) => onSelected(context, value),
                itemBuilder: (_) => [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Row(
                      children: [
                        const SizedBox(width: 2),
                        SvgPicture.asset(
                          "assets/icons/add_bookmark.svg",
                          height: 20,
                          width: 20,
                          color: Colors.blueGrey.shade700,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Bookmark",
                          style: GoogleFonts.inter(
                            color: Colors.blueGrey.shade700,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.flag_circle_rounded,
                          size: 25.5,
                          color: Colors.blueGrey.shade700,
                        ),
                        const SizedBox(width: 9),
                        Text(
                          "Report",
                          style: GoogleFonts.inter(
                            color: Colors.blueGrey.shade700,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                icon: const Icon(
                  Icons.more_horiz_rounded,
                  color: Constants.postOptionIconColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onSelected(context, value) {}
}
