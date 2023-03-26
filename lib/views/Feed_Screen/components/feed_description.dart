import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readmore/readmore.dart';

import '../../../constants/constants.dart';
import '../../components/circle_profile_pic.dart';
import '../../components/person_detail.dart';
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
    final localUser = ref.watch(localUserProvider);
    void like() {}
    void bookmark() {}
    void share() {}
    final listOfFunctions = [like, commentFunc, bookmark, share];
    return Column(
      children: <Widget>[
        Row(
          children: [
            const CircleProfilePic(radius: 22.5),
            const Spacer(flex: 1),
            PersonDetail(
              user: localUser,
            ),
            const Spacer(flex: 25),
            const Icon(
              Icons.more_vert_outlined,
              color: Color.fromRGBO(32, 33, 37, 1),
              size: 24,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: ReadMoreText(
            // feedPost.text,
            "In the previous section, we saw changing the status bar color using the appbar. But what if you want to change the status bar color without the appbar. Here’s the solution. You can simply wrap your top widget inside another widget called AnnotatedRegion. Using the AnnotatedRegion’s value property, you can set the status bar color.",
            style: GoogleFonts.firaSans(
              fontSize: 16.5,
              letterSpacing: 0.1,
              height: 1.25,
            ),
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
        MediaContainer(post: feedPost),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '123 likes',
              style: GoogleFonts.manrope(color: Colors.black87),
            ),
            Text(
              '12 comments',
              style: GoogleFonts.manrope(color: Colors.black87),
            ),
          ],
        ),
        const Divider(
          height: 25,
          color: Colors.grey,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ...List.generate(
              4,
              (index) => GestureDetector(
                onTap: () => listOfFunctions[index](),
                child: SvgPicture.asset(
                  Constants.postOptionIcons[index],
                  width: 26,
                  height: 26,
                  color: const Color(0xFF0073B1),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
