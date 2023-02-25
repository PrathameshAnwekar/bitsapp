import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bitsapp/constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/src/framework.dart';
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
      appBar: buildAppBar(otherUser.name),
      body: Body(
        chatRoomUid: chatRoomUid,
        receiver: otherUser,
      ),
    );
  }

  AppBar buildAppBar(String name) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const BackButton(),
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/user2.png"),
          ),
          const SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.local_phone),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          onPressed: () {},
        ),
        const SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }
}
