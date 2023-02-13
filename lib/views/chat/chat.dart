import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:bitsapp/constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'components/body.dart';

class ChatRoomScreen extends ConsumerWidget {
  static const routeName = "/chat-room-creen";
  final String chatRoomUid;

  const ChatRoomScreen({super.key, required this.chatRoomUid});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRoom = ref.watch(chatRoomsProvider).firstWhere((element) => element.uid == chatRoomUid);
    final contactsList = ref.watch(contactsListProvider);
    final BitsUser otherUser = contactsList.firstWhere((element) => element.uid == chatRoom.userUidList.firstWhere((element) => element != ref.read(localUserProvider).uid));
    return Scaffold(
      appBar: buildAppBar(otherUser.name),
      body: Body(
        chatRoomUid: chatRoomUid,
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
            children:  [
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
