import 'package:bitsapp/constants.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:bitsapp/views/chat/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'chat_input_field.dart';
import 'text_message.dart';

class Body extends ConsumerWidget {
  final String chatRoomUid;

  const Body({super.key, required this.chatRoomUid});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatStream = ref.watch(chatStreamProvider(chatRoomUid));
    final messages = ref
        .watch(chatRoomsProvider)
        .firstWhere((element) => element.uid == chatRoomUid)
        .messages;
    return Column(
      children: [
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: chatStream.when(
                  data: ( snapshot)  {
                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) =>
                          TextMessage(message: messages[index]),
                    );
                  },
                  error: (e, stackTrace) =>
                      Text("Please check you Internet Connection $e"),
                  loading: () => CircularProgressIndicator.adaptive())),
        ),
        ChatInputField(chatRoomUid: chatRoomUid),
      ],
    );
  }
}
