import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/constants.dart';
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
      backgroundColor: Colors.white,
    );
  }

  AppBar buildAppBar(String name) {
    return AppBar(
      toolbarHeight: 63,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      centerTitle: false,
      titleSpacing: 0.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 23,
            backgroundImage: AssetImage("assets/images/user2.png"),
          ),
          const SizedBox(width: Constants.kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.dmSans(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Online Now",
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
