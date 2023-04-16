import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/views/chat/components/text_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.messages,
    required this.replyOfHook,
    required this.index,
    required this.replyOfText,
    required this.selectMessageForReply,required this.replyText,
  });
  final Message message;
  final List<Message> messages;
  final ValueNotifier<String?> replyOfHook;
  final int index;
  final ValueNotifier<String?> replyOfText;
  final String? replyText;
  final Function selectMessageForReply;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onDoubleTap: () {
          selectMessageForReply(replyOfHook, message, index, replyOfText);
        },
        child: TextMessage(
          message: message,
          replyText: replyText,
        ));
    ;
  }
}
