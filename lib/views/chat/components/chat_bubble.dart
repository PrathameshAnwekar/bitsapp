import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/views/chat/components/text_message.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../models/bits_user.dart';

class ChatBubble extends ConsumerWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.ref,
    required this.selectMessageForReply,
    required this.replyText,
    required this.focusNode,
  });
  final Message message;
  final WidgetRef ref;
  final FocusNode focusNode;
  final String? replyText;
  final Function selectMessageForReply;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localUser = ref.watch(localUserProvider);
    bool isSender = message.sender == localUser.uid;
    return isSender
        ? SwipeTo(
            onLeftSwipe: () {
              selectMessageForReply(
                ref,
                message,
              );
              focusNode.requestFocus();
            },
            child: TextMessage(
              isSender: isSender,
              message: message,
              replyText: replyText,
            ),
          )
        : SwipeTo(
            onRightSwipe: () {
              selectMessageForReply(
                ref,
                message,
              );
              focusNode.requestFocus();
            },
            child: TextMessage(
              isSender: isSender,
              message: message,
              replyText: replyText,
            ),
          );
  }
}
