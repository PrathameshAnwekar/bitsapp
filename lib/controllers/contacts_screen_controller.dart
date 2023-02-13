import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/views/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContactsScreenController {
  static void addNewChatRoom(String localUserUid, String userUid,
      BuildContext context, WidgetRef ref) {
    final uid = localUserUid.compareTo(userUid) < 0 ?  localUserUid + userUid : userUid + localUserUid;
    if(ref.read(localUserProvider).chatRooms.contains(uid)) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return ChatRoomScreen(chatRoomUid: uid);
        },
      ));
      return;
    }
    final newChatRoom =
        ChatRoom(uid: uid, userUidList: [localUserUid, userUid], messages: []);
    ref
        .read(localUserProvider.notifier)
        .addChatRoom(uid);
    ref.read(chatRoomsProvider.notifier).addChatRoom(newChatRoom, localUserUid, userUid);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return ChatRoomScreen(chatRoomUid: uid);
      },
    ));
  }
}
