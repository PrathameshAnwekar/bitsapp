import 'package:bitsapp/main.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/services/google_auth_service.dart';
import 'package:bitsapp/views/chat/chat.dart';
import 'package:bitsapp/views/chat/chat_card.dart';
import 'package:bitsapp/views/chat/contacts_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatsScreen extends HookConsumerWidget {
  const ChatsScreen({super.key});
  static const routeName = "/chats-screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localuser = ref.watch(localUserProvider);
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(localuser.chatRooms),
      floatingActionButton: FloatingActionButton(
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
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text("Chats"),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const ContactsScreen();
              },
            ));
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ChatRoomScreen(chatRoomUid: chatsData[index].uid);
              }));
            },
          ),
        ),
      ),
    ],
  );
}
