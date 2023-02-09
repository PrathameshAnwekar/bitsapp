import 'package:bitsapp/components/filled_outline_button.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/views/chat/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});
  static const routeName = "/chats-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(ChatRoom.chatsData),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
            press: () {},
          ),
        ),
      ),
    ],
  );
}
