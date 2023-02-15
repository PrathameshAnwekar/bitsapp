import 'package:bitsapp/views/job_internship_screen/Components/person_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../../Components/circle_profile_pic.dart';
import '../Comment_Screen/comment_screen.dart';
import 'feed_detail_screen.dart';

class FeedContainer extends StatelessWidget {
  const FeedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const FeedDetailScreen())),
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(1),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: ReadMoreText(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur quis nunc ut magna efficitur feugiat id id sapien. Nam mi quam, lobortis eu venenatis ultrices, consequat et tortor. Morbi nibh quam, euismod ut porttitor id, mollis scelerisque tellus. Nunc commodo dui id fringilla consequat. Quisque odio nulla, blandit eu est quis, pulvinar dictum ipsum. Ut ut sagittis lorem, tempus blandit eros. ",
                textAlign: TextAlign.start,
                colorClickableText: Colors.grey,
                style:
                    GoogleFonts.manrope(color: Colors.black87, fontSize: 15.2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
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
            ),
            const Divider(
              height: 25,
              color: Colors.grey,
              indent: 14,
              endIndent: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/Icons/like.svg',
                  width: 26,
                  height: 26,
                  color: Colors.black,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CommentScreen()));
                  },
                  child: SvgPicture.asset(
                    'assets/Icons/comment.svg',
                    width: 26,
                    height: 26,
                    color: Colors.black,
                  ),
                ),
                SvgPicture.asset(
                  'assets/Icons/bookmark.svg',
                  width: 28,
                  height: 28,
                  color: Colors.black,
                ),
                SvgPicture.asset(
                  'assets/Icons/share.svg',
                  width: 26,
                  height: 26,
                  color: Colors.black,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
