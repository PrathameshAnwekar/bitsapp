import 'package:bitsapp/controllers/chats_screen_controller.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/views/chat/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatsScreen extends HookConsumerWidget {
  const ChatsScreen({super.key});
  static const routeName = "/chats-screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatrooms = ref.watch(chatRoomsProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            ChatsScreenController.gotoContactsScreen(context);
          },
        ),
      ],
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "Chat",
            style: GoogleFonts.rubik(
              color: const Color(0xFF2D3F65),
              fontSize: 28,
            ),
          ),
        ),
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(30),
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     child: TextFormField(
        //       cursorColor: const Color(0xFF676767),
        //       style: GoogleFonts.rubik(
        //         color: const Color(0xFF676767),
        //         fontSize: 17,
        //       ),
        //       textCapitalization: TextCapitalization.words,
        //       decoration: InputDecoration(
        //         contentPadding: const EdgeInsets.only(top: 15),
        //         focusedBorder: const UnderlineInputBorder(
        //           borderSide: BorderSide(
        //             width: 1.2,
        //             color: Color(0xFF2D3F65),
        //           ),
        //         ),
        //         enabledBorder: const UnderlineInputBorder(
        //           borderSide: BorderSide(
        //             width: 1.2,
        //             color: Color(0xFF2D3F65),
        //           ),
        //         ),
        //         hintText: "Search...",
        //         hintStyle: GoogleFonts.rubik(
        //           color: const Color(0xFF2D3F65),
        //           fontSize: 14,
        //         ),
        //         suffixIcon: const Padding(
        //           padding: EdgeInsets.only(top: 8.0),
        //           child: Icon(
        //             Icons.search,
        //             color: Color(0xFF2D3F65),
        //             size: 22,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ),
      body: buildBody(chatrooms),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(right: 12, bottom: 100),
      //   child: FloatingActionButton(
      //     onPressed: () async {
      //       if (await GoogleAuthService.signOut()) {
      //         Navigator.of(context)
      //             .pushNamedAndRemoveUntil(MyApp.routeName, (route) => false);
      //       }
      //     },
      //     child: const Icon(
      //       Icons.person_add_alt_1,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
    );
  }

  buildBody(chatsData) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: ListView.separated(
            itemCount: chatsData.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () =>
                  ChatsScreenController.gotoChatRoom(context, chatsData, index),
              child: ChatCard(
                chatRoom: chatsData[index],
                index: index,
              ),
            ),
            separatorBuilder: (context, index) => const Divider(
              indent: 77,
              endIndent: 15,
              color: Color.fromRGBO(131, 144, 159, 0.7),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
