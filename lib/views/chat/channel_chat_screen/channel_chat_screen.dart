import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/views/chat/chat_room_screen.dart';
import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../channel_chat_screen/components/channel_app_bar.dart';
import '../channel_chat_screen/components/channel_chat_input_field.dart';
import '../components/chat_bubble.dart';

class ChannelChatScreen extends HookConsumerWidget {
  ChannelChatScreen({
    super.key,
    required this.channelName,
  });
  final String channelName;
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.kSecondaryColor,
        appBar: ChannelAppBar(channelName: channelName),
        body: Column(
          children: [
            Expanded(
              child: FirestoreListView(
                reverse: true,
                query: FirebaseFirestore.instance
                    .collection('Channels')
                    .doc(channelName)
                    .collection("messages")
                    .orderBy('time', descending: true),
                pageSize: 20,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, snapshot) {
                  final Message message = Message.fromJson(snapshot.data());
                  return ChatBubble(
                    key: key,
                    message: message,
                    replyText: "",
                    ref: ref,
                    selectMessageForReply: () {
                      ref.read(replyOfMessageProvider.notifier).state = message;
                    },
                    focusNode: focusNode,
                  );
                },
              ),
            ),
            ChannelChatInputField(
              chatRoomName: channelName,
              reset: () {
                ref.read(replyOfMessageProvider.notifier).state = null;
              },
              senderName: ref.read(localUserProvider).name,
            ),
          ],
        ),
      ),
    );
  }
}
