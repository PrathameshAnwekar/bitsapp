import 'package:bitsapp/controllers/chats_screen_controller.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/services/firestore_service.dart';
import 'package:bitsapp/views/chat/channel_chat_screen.dart';
import 'package:bitsapp/views/chat/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatsScreen extends HookConsumerWidget {
  const ChatsScreen({super.key});
  static const routeName = "/chats-screen";
  static final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh(WidgetRef ref) async {
    // monitor network fetch
    await FirestoreService.initialiseChatRooms(ref);
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());

    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatrooms = ref.watch(chatRoomsProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => const ChannelChatScreen())));
        },
        child: const Icon(Icons.message),
      ),
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
      body: buildBody(chatrooms, ref),
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

  Column buildBody(chatsData, ref) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            controller: _refreshController,
            header: const WaterDropMaterialHeader(),
            onLoading: () => _onLoading(),
            onRefresh: () => _onRefresh(ref),
            child: ListView.separated(
              itemCount: chatsData.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => ChatsScreenController.gotoChatRoom(
                    context, chatsData, index),
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
        ),
      ],
    );
  }
}
