import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/models/message.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatController {
  static void sendMessage(
      WidgetRef ref, TextEditingController textController, String chatRoomUid, String recieverFcmUid, String senderName) {
    final Message m = Message(
      sender: ref.read(localUserProvider).uid,
      text: textController.text,
      time: DateTime.now().millisecondsSinceEpoch,
    );

    ref.read(chatRoomsProvider.notifier).addMessage(chatRoomUid, m, recieverFcmUid, senderName);
    textController.clear();
  }
}
