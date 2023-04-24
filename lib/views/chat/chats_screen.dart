import 'package:bitsapp/constants/constants.dart';
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
    FocusNode focusNode = FocusNode();
    ExpandableController controller = ExpandableController();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
            buildChannelsBody(controller, focusNode),
            buildMessagesBody(chatrooms, ref),
          ],
        ),
      ),
    );
  }

  Widget buildChannelsBody(
      ExpandableController controller, FocusNode focusNode) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Column(
        children: <Widget>[
          ExpandablePanel(
            controller: controller,
            header: SizedBox(
              height: 50,
              child: TextFormField(
                focusNode: focusNode,
                onTap: () {
                  controller.toggle();
                  focusNode.hasFocus
                      ? focusNode.unfocus()
                      : focusNode.requestFocus();
                },
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
            theme: ExpandableThemeData(
              expandIcon: Icons.keyboard_arrow_down_rounded,
              collapseIcon: Icons.keyboard_arrow_up_rounded,
              useInkWell: false,
              iconColor: Colors.black.withOpacity(0.65),
              iconSize: 33,
            ),
            collapsed: const SizedBox(),
            expanded: SizedBox(
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
          ),
        ],
      ),
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
            enablePullDown: true,
            enablePullUp: false,
            controller: _refreshController2,
            header: const WaterDropMaterialHeader(),
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
