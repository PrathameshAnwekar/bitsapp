import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/message.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

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
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
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
              child: Column(
                children: [
                  if (replyText != null)
                    Container(
                      // color: Colors.transparent.withOpacity(0.1),
                      color: Colors.white,
                      child: Text(replyText!),
                    ),
                  Text(
                    message.text,
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      height: 1.2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              DateFormat('HH:mm')
                  .format(DateTime.fromMillisecondsSinceEpoch(message.time)),
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
