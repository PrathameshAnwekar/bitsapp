import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../../Components/circle_profile_pic.dart';
import '../../Components/person_detail.dart';
import 'post_options.dart';

class FeedDesc extends StatelessWidget {
  final bool isFeedScreen;
  final GlobalKey itemKey;
  const FeedDesc(
      {super.key, required this.itemKey, required this.isFeedScreen});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: const [
            CircleProfilePic(radius: 20),
            Spacer(flex: 1),
            PersonDetail(),
            Spacer(flex: 25),
            Icon(
              Icons.more_vert_outlined,
              color: Color.fromRGBO(32, 33, 37, 1),
              size: 24,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: ReadMoreText(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur quis nunc ut magna efficitur feugiat id id sapien. Nam mi quam, lobortis eu venenatis ultrices, consequat et tortor. Morbi nibh quam, euismod ut porttitor id, mollis scelerisque tellus. Nunc commodo dui id fringilla consequat. Quisque odio nulla, blandit eu est quis, pulvinar dictum ipsum. Ut ut sagittis lorem, tempus blandit eros. ",
            style: const TextStyle(
              fontSize: 16,
            ),
            trimCollapsedText: isFeedScreen ? "" : "read more",
            trimExpandedText: isFeedScreen ? "" : "show less",
            trimMode: isFeedScreen ? TrimMode.Length : TrimMode.Line,
            trimLines: 100000,
            trimLength: 240,
          ),
        ),
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
            PostOptionButtons(
              onPressed: () {},
              icon: 'assets/Icons/like.svg',
            ),
            PostOptionButtons(
              onPressed: () async {
                final context = itemKey.currentContext!;
                await Scrollable.ensureVisible(context,
                    duration: const Duration(milliseconds: 600));
              },
              icon: 'assets/Icons/comment.svg',
            ),
            PostOptionButtons(
              onPressed: () {},
              icon: 'assets/Icons/comment.svg',
            ),
            PostOptionButtons(
              onPressed: () {},
              icon: 'assets/Icons/share.svg',
            ),
          ],
        ),
      ],
    );
  }
}
