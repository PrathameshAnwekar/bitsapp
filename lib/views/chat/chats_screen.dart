import 'package:bitsapp/main.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/views/chat/chat.dart';
import 'package:bitsapp/views/chat/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:bitsapp/services/google_auth_service.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});
  static const routeName = "/chats-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(ChatRoom.chatsData),
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

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text("Chats"),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
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
