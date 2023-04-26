import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/views/chat/components/reply_message.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../constants/constants.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
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
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (replyText != null)
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 4),
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
                Text(
                  message.text,
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    height: 1.2,
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
