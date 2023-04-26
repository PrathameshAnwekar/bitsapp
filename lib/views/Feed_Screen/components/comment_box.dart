import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/comment.dart';
import 'package:bitsapp/storage/hiveStore.dart';
import 'package:bitsapp/views/components/circle_profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import '../../profile_screen/profile_screen.dart';

class CommentsBox extends ConsumerWidget {
  const CommentsBox({super.key, required this.comment});
  final Comment comment;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BitsUser commentPoster =
        HiveStore.getUserFromStorage(uid: comment.posterUid) ?? BitsUser.dummy;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: ProfileScreen(commentPoster),
            duration: const Duration(milliseconds: 250),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const CircleProfilePic(radius: 18),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.fromLTRB(10, 4, 10, 10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      commentPoster.name,
                      style: GoogleFonts.dmSans(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      comment.text,
                      style: GoogleFonts.dmSans(
                        color: Colors.black.withOpacity(0.65),
                        fontSize: 15,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
