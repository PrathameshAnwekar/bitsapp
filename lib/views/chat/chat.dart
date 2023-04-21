import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:bitsapp/views/chat/components/chat_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/body.dart';

final chatStreamProvider =
    StreamProvider.family<dynamic, String>((ref, chatRoomUid) async* {
  final chatStream = FirebaseFirestore.instance
      .collection("ChatRooms")
      .doc(chatRoomUid)
      .snapshots();

  ref.onDispose(() {
    chatStream.drain();
  });

  await for (final value in chatStream) {
    if (value.data() != null) {
      final chatRoom = ChatRoom.fromJson(value.data()!);
      vlog("chatRoom: ${chatRoom.toJson()}");
      ref
          .read(chatRoomsProvider.notifier)
          .updateChatRoom(chatRoomUid, chatRoom.messages);
    }
    yield value;
  }
});

class ChatRoomScreen extends ConsumerWidget {
  static const routeName = "/chat-room-creen";
  final String chatRoomUid;

  const ChatRoomScreen({super.key, required this.chatRoomUid});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRoom = ref
        .watch(chatRoomsProvider)
        .firstWhere((element) => element.uid == chatRoomUid);
    final contactsList = ref.watch(contactsListProvider);
    final BitsUser otherUser = contactsList.firstWhere(
        (element) =>
            element.uid ==
            chatRoom.userUidList.firstWhere(
                (element) => element != ref.read(localUserProvider).uid,
                orElse: () => "-1"),
        orElse: () => ref.read(localUserProvider));
    return Scaffold(
      appBar: ChatAppBar(name: otherUser.name),
      body: Body(
        chatRoomUid: chatRoomUid,
        receiver: otherUser,
      ),
      backgroundColor: Colors.white,
    );
  }
}
