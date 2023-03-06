import 'package:bitsapp/controllers/chats_screen_controller.dart';
import 'package:bitsapp/main.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/services/google_auth_service.dart';
import 'package:bitsapp/views/chat/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatsScreen extends HookConsumerWidget {
  const ChatsScreen({super.key});
  static const routeName = "/chats-screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatrooms = ref.watch(chatRoomsProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: buildBody(chatrooms),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 12, bottom: 100),
        child: FloatingActionButton(
          onPressed: () async {
            if (await GoogleAuthService.signOut()) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(MyApp.routeName, (route) => false);
            }
          },
          child: const Icon(
            Icons.person_add_alt_1,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: const Text("Chats"),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            ChatsScreenController.gotoContactsScreen(context);
          },
        ),
      ],
    );
  }
}

buildBody(chatsData) {
  return Column(
    children: [
      Expanded(
        child: ListView.builder(
          itemCount: chatsData.length,
          itemBuilder: (context, index) => ChatCard(
            chatRoom: chatsData[index],
            press: () {
              ChatsScreenController.gotoChatRoom(context, chatsData, index);
            },
          ),
        ),
      ),
    ],
  );
}
