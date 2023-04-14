import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/message.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/constants.dart';

class TextMessage extends ConsumerWidget {
  const TextMessage({
    Key? key,
    required this.message,
    required this.replyText,
  }) : super(key: key);

  final Message message;
  final String? replyText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localUser = ref.watch(localUserProvider);
    bool isSender = message.sender == localUser.uid;
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (replyText != null)
              Container(
                child: Text(replyText!),
              ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.kDefaultPadding * 0.75 + 3,
                vertical: Constants.kDefaultPadding / 2 + 3,
              ),
              constraints: const BoxConstraints(maxWidth: 300),
              decoration: BoxDecoration(
                color: isSender
                    ? const Color.fromRGBO(221, 221, 221, 0.7)
                    : const Color(0xFFFB6D62).withOpacity(0.32),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                message.text,
                style: GoogleFonts.dmSans(
                  fontSize: 15,
                  height: 1.2,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              timeAgo(DateTime.fromMillisecondsSinceEpoch(message.time)),
              style: GoogleFonts.dmSans(
                fontSize: 11,
                height: 1.8,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}

String timeAgo(DateTime d) {
  Duration diff = DateTime.now().difference(d);
  if (diff.inDays > 365)
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  if (diff.inDays > 30)
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  if (diff.inDays > 7)
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  if (diff.inDays > 0)
    return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
  if (diff.inHours > 0)
    return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
  if (diff.inMinutes > 0)
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
  return "just now";
}
