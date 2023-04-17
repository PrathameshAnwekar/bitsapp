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
        padding: const EdgeInsets.only(top: 15),
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
                color: isSender ? Constants.kPrimaryColor : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                  bottomLeft: Radius.circular(isSender ? 10 : 0),
                  bottomRight: Radius.circular(isSender ? 0 : 10),
                ),
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
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      height: 1.2,
                      // fontWeight: FontWeight.w400,
                      color: isSender ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              DateFormat('HH:mm')
                  .format(DateTime.fromMillisecondsSinceEpoch(message.time)),
              style: GoogleFonts.roboto(
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
