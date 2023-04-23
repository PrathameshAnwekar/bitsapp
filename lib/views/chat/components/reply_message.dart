import 'package:bitsapp/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReplyMessageWidget extends StatelessWidget {
  final String message;
  final String receiverUsername;
  final VoidCallback? onCancelReply;

  const ReplyMessageWidget({
    required this.message,
    this.onCancelReply,
    required this.receiverUsername,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          children: [
            Container(
              color: Constants.kPrimaryColor,
              width: 4,
            ),
            const SizedBox(width: 8),
            Expanded(child: buildReplyMessage()),
          ],
        ),
      );

  Widget buildReplyMessage() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  receiverUsername,
                  style: GoogleFonts.roboto(
                    fontSize: 14.3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              onCancelReply != null
                  ? GestureDetector(
                      onTap: onCancelReply,
                      child: const Icon(Icons.close, size: 16),
                    )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: GoogleFonts.roboto(
              color: Colors.black54,
              fontSize: 15,
            ),
          ),
        ],
      );
}
