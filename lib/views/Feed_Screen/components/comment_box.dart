import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/comment.dart';
import 'package:bitsapp/views/components/circle_profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommentsBox extends ConsumerWidget {
  const CommentsBox({super.key, required this.comment});
  final Comment comment;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentPoster = ref
        .read(contactsListProvider)
        .where((element) => element.uid == comment.posterUid);
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
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
                    commentPoster.first.name,
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
    );
  }
}
