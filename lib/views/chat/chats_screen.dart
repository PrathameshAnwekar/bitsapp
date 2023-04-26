import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_channel.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/services/firestore_service.dart';
import 'package:bitsapp/storage/hiveStore.dart';
import 'package:bitsapp/views/chat/channel_chat_screen/channel_chat_screen.dart';
import 'package:bitsapp/views/chat/chat_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../Components/person_detail.dart';

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
                text: "Channels",
              ),
              Tab(
                text: "Messages",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildChannelsBody(chatrooms, ref),
            buildMessagesBody(chatrooms, ref),
          ],
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  Widget buildChannelsBody(chatsData, ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: ExpandablePanel(
            header: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Text(
                "All Channels",
                style: GoogleFonts.dmSans(
                  color: const Color(0xFF4D5470),
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
            ),
            theme: ExpandableThemeData(
              tapHeaderToExpand: true,
              useInkWell: false,
              expandIcon: Icons.keyboard_arrow_down_rounded,
              collapseIcon: Icons.keyboard_arrow_up_rounded,
              iconColor: Colors.black.withOpacity(0.65),
              iconSize: 33,
            ),
            collapsed: const SizedBox(),
            expanded: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
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
                        hintText: "Search channels...",
                        hintStyle: GoogleFonts.roboto(fontSize: 15.5),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black54,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          height: 150,
                          color: Colors.red,
                          margin: const EdgeInsets.all(10),
                        );
                      },
                      itemCount: 5,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Text(
            "Joined Channels",
            style: GoogleFonts.dmSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // Expanded(
        //   child: ListView.separated(
        //     itemCount: chatsData.length,
        //     itemBuilder: (context, index) => ChatCard(
        //       chatRoom: chatsData[index],
        //       index: index,
        //     ),
        //     separatorBuilder: (context, index) => const Divider(
        //       indent: 82,
        //       endIndent: 15,
        //       color: Color.fromARGB(255, 234, 236, 243),
        //       height: 1.5,
        //     ),
        //   ),
        // ),
        Expanded(
          child: FirestoreListView(
            query: FirebaseFirestore.instance.collection('Channels'),
            pageSize: 20,
            itemBuilder: (context, snapshot) {
              final data = snapshot.data();
              final ChatChannel channel = ChatChannel(
                name: data['name'],
                messages: [],
                lastMessage: data['lastMessage'] != null
                    ? Message.fromJson(data['lastMessage'])
                    : Message.dummyMessage,
              );
              final lastMessageSender = HiveStore.getUserFromStorage(
                      uid: channel.lastMessage.sender) ??
                  BitsUser.dummy;
              return ListTile(
                horizontalTitleGap: 12,
                splashColor: Colors.transparent,
                minVerticalPadding: 0,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChannelChatScreen(
                        channelName: channel.name,
                      ),
                    ),
                  );
                },
                leading: const CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1556157382-97eda2d62296?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80"),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      channel.name,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        height: 1.2,
                        // fontWeight: index < 1 ? FontWeight.w700 : FontWeight.w400,
                      ),
                    ),
                    Text(
                      timeAgo(
                        DateTime.fromMillisecondsSinceEpoch(
                          channel.lastMessage.time,
                        ),
                      ),
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        color: const Color.fromRGBO(131, 144, 159, 1),
                      ),
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(right: 20, top: 5),
                  child: Text(
                    "${lastMessageSender.name}: ${channel.lastMessage.text}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.rubik(
                      color: const Color.fromRGBO(131, 144, 159, 1),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildMessagesBody(chatsData, ref) {
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
                hintText: "Search messages...",
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
            controller: _refreshController2,
            // header: const WaterDropMaterialHeader(
            //   backgroundColor: Constants.kPrimaryColor,
            // ),
            header: const MaterialClassicHeader(
              color: Constants.kPrimaryColor,
            ),
            onLoading: () => _onLoading(),
            onRefresh: () => _onRefresh(ref),
            child: ListView.separated(
              itemCount: chatsData.length,
              itemBuilder: (context, index) => ChatCard(
                chatRoom: chatsData[index],
                index: index,
              ),
              separatorBuilder: (context, index) => const Divider(
                indent: 82,
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
