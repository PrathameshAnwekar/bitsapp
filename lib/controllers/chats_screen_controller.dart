import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/views/chat/chat.dart';
import 'package:bitsapp/views/chat/contacts_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatsScreenController {
  static void gotoContactsScreen(context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const ContactsScreen();
      },
    ));
  }

  static void gotoChatRoom(context, chatsData, index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ChatRoomScreen(chatRoomUid: chatsData[index].uid);
    }));
  }

  static void addNewChatRoom(String localUserUid, String userUid,
      BuildContext context, WidgetRef ref) async {
    final uid = localUserUid.compareTo(userUid) < 0
        ? '$localUserUid$userUid'
        : '$userUid$localUserUid';
    if (ref.read(localUserProvider).chatRooms.contains(uid)) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return ChatRoomScreen(chatRoomUid: uid);
        },
      ));
      return;
    }
    final newChatRoom =
        ChatRoom(uid: uid, userUidList: [localUserUid, userUid], messages: []);
    ref.read(localUserProvider.notifier).addChatRoom(uid);
    await ref
        .read(chatRoomsProvider.notifier)
        .addChatRoom(newChatRoom, localUserUid, userUid)
        .then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return ChatRoomScreen(chatRoomUid: uid);
        },
      ));
    });
  }
}
