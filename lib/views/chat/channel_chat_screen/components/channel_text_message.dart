import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/views/chat/components/reply_message.dart';
import 'package:bitsapp/views/chat/components/text_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../constants/constants.dart';
import '../../../../models/bits_user.dart';
import '../../../../storage/hiveStore.dart';
import '../../../profile_screen/profile_screen.dart';

class ChannelTextMessage extends StatelessWidget {
  const ChannelTextMessage({
    Key? key,
    required this.message,
    required this.replyText,
    required this.isSender,
  }) : super(key: key);

  final Message message;
  final String? replyText;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    final poster =
        HiveStore.getUserFromStorage(uid: message.sender) ?? BitsUser.dummy;
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          TextBox(
            isSender: isSender,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isSender)
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.bottomToTop,
                        child: ProfileScreen(poster),
                        duration: const Duration(milliseconds: 250),
                      ),
                    ),
                    child: Text(
                      "~${poster.name}",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        color: Constants.inactiveIconColor,
                        fontSize: 13.5,
                        height: 1.2,
                      ),
                    ),
                  ),
                if (replyText != "")
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 4, left: 9, right: 9),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10),
                        topRight: const Radius.circular(10),
                        bottomLeft: Radius.circular(isSender ? 10 : 0),
                        bottomRight: Radius.circular(isSender ? 0 : 10),
                      ),
                      color: Colors.white,
                    ),
                    child: ReplyMessageWidget(
                      message: replyText!,
                      receiverUsername: "Prathamesh Anwekar",
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: Text(
                    message.text,
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      height: 1.2,
                      color: isSender ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            DateFormat('HH:mm')
                .format(DateTime.fromMillisecondsSinceEpoch(message.time)),
            style: GoogleFonts.roboto(
              fontSize: 10,
              height: 1.8,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
