import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/controllers/chats_screen_controller.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/services/firestore_service.dart';
import 'package:bitsapp/views/chat/chat_card.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatsScreen extends HookConsumerWidget {
  const ChatsScreen({super.key});
  static const routeName = "/chats-screen";
  static final RefreshController _refreshController2 =
      RefreshController(initialRefresh: false);

  void _onRefresh(WidgetRef ref) async {
    await FirestoreService.initialiseChatRooms(ref);
    _refreshController2.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController2.loadComplete();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatrooms = ref.watch(chatRoomsProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: TabBar(
            dividerColor: Constants.kSecondaryColor,
            labelColor: Constants.kPrimaryColor,
            unselectedLabelStyle:
                GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600),
            labelStyle:
                GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600),
            indicatorColor: Constants.kPrimaryColor,
            tabs: const [
              Tab(
                text: "Messages",
              ),
              Tab(
                text: "Channels",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildMessagesBody(chatrooms, ref),
            buildChannelsBody(),
          ],
        ),
      ),
    );
  }

  Column buildChannelsBody() {
    return Column(
      children: <Widget>[
        ExpandablePanel(
          header: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              "All Channels",
              style: GoogleFonts.roboto(
                color: const Color(0xFF4D5470),
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
          ),
          theme: ExpandableThemeData(
            iconColor: Colors.black.withOpacity(0.8),
            iconSize: 26,
          ),
          collapsed: const SizedBox(),
          expanded: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[],
          ),
        ),
      ],
    );
  }

  Column buildMessagesBody(chatsData, ref) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
          child: SizedBox(
            height: 50,
            child: TextFormField(
              cursorColor: Colors.black,
              style: GoogleFonts.roboto(fontSize: 15.5),
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                fillColor: Constants.kSecondaryColor,
                filled: true,
                contentPadding: const EdgeInsets.only(top: 9.9),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Constants.kSecondaryColor,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Constants.kSecondaryColor,
                  ),
                ),
                hintText: "Search...",
                hintStyle: GoogleFonts.roboto(fontSize: 15.5),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black54,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SmartRefresher(
            key: const ValueKey("Chat"),
            enablePullDown: true,
            enablePullUp: false,
            controller: _refreshController2,
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
                color: Color.fromARGB(255, 234, 236, 243),
                height: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
