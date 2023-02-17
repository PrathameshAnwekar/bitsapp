import 'package:bitsapp/views/chat/chat.dart';
import 'package:bitsapp/views/chat/contacts_screen.dart';
import 'package:flutter/material.dart';

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
}
