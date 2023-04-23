import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/body.dart';
import 'components/chat_app_bar.dart';

class ChatRoomScreen extends HookConsumerWidget {
  static const routeName = "/chat-room-creen";
  final String chatRoomUid;
  
  const ChatRoomScreen({super.key, required this.chatRoomUid});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRoom = ref
        .watch(chatRoomsProvider)
        .firstWhere((element) => element.uid == chatRoomUid);
    final chatStream = ref.watch(chatStreamProvider(chatRoomUid));
    final contactsList = ref.watch(contactsListProvider);
    final BitsUser otherUser = contactsList.firstWhere(
        (element) =>
            element.uid ==
            chatRoom.userUidList.firstWhere(
                (element) => element != ref.read(localUserProvider).uid,
                orElse: () => "-1"),
        orElse: () => ref.read(localUserProvider));
    return WillPopScope(
      onWillPop: () {
        ref.read(replyOfProvider.notifier).state = null;
        ref.read(replyOfTextProvider.notifier).state = null;
        return Future.value(true);
      },
      child: Scaffold(
        appBar: ChatAppBar(name: otherUser.name),
        body: Body(
          chatRoomUid: chatRoomUid,
          receiver: otherUser,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}

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

//Using these instead of hooks to avoid rebuilding the whole screen
final replyOfProvider = StateProvider.autoDispose<String?>((ref) => null);
final replyOfTextProvider = StateProvider.autoDispose<String?>((ref) => null);
