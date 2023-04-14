import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/views/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatController {
  static void sendMessage(
      {required WidgetRef ref,
      required TextEditingController textController,
      required String chatRoomUid,
      required String receiverFcmToken,
      required String senderName,
      required String? replyOf}) {
    final Message m = Message(
      sender: ref.read(localUserProvider).uid,
      text: textController.text,
      time: DateTime.now().millisecondsSinceEpoch,
      type: MessageType.text,
      replyOf: replyOf,
    );

    ref
        .read(chatRoomsProvider.notifier)
        .addMessage(chatRoomUid, m, receiverFcmToken, senderName);
    textController.clear();
  }

  
}
