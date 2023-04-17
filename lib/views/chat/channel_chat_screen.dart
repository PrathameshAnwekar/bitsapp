import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:bitsapp/views/chat/components/channel_chat_input_field.dart';
import 'package:bitsapp/views/chat/components/chat_bubble.dart';
import 'package:bitsapp/views/chat/components/chat_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

int i = 0;

class ChannelChatScreen extends HookConsumerWidget {
  const ChannelChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
                   print("rebuildx" + (i++).toString());

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("Announcements")),
      body: Column(children: [
        Expanded(
          child: FirestoreListView(
              reverse: true,
              query: FirebaseFirestore.instance
                  .collection('Channels')
                  .doc("Announcements")
                  .collection("messages")
                  .orderBy('time', descending: true),
              pageSize: 20,
              itemBuilder: (context, snapshot) {
                final Message message = Message.fromJson(snapshot.data());
                return Padding(
                    padding: EdgeInsets.only(top: 50, bottom: 50),
                    child: Text(message.text));
              }),
        ),
        ChannelChatInputField(
          chatRoomUid: 'Announcements',
          receiverFcmToken: 'null',
          reset: () {},
          senderName: 'Prathamesh',
        ),
      ]),
    ));
  }
}
