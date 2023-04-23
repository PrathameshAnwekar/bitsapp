import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ChatCard extends HookConsumerWidget {
  const ChatCard({
    Key? key,
    required this.chatRoom,
    required this.index,
  }) : super(key: key);

  final ChatRoom chatRoom;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localUser = ref.watch(localUserProvider);
    final contactsList = ref.watch(contactsListProvider);
    final lastMessage = chatRoom.messages[chatRoom.messages.length - 1];
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10 * 0.75),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(index < 1
                ? "https://images.unsplash.com/photo-1556157382-97eda2d62296?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80"
                : "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1771&q=80"),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chatRoom.userUidList[0] == localUser.uid
                            ? contactsList
                                .singleWhere((element) =>
                                    element.uid == chatRoom.userUidList[1])
                                .name
                            : contactsList
                                .singleWhere((element) =>
                                    element.uid == chatRoom.userUidList[0])
                                .name,
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          height: 1.2,
                          fontWeight:
                              index < 1 ? FontWeight.w700 : FontWeight.w400,
                        ),
                      ),
                      Text(
                        timeAgo(
                          DateTime.fromMillisecondsSinceEpoch(
                            lastMessage.time,
                          ),
                        ),
                        style: GoogleFonts.roboto(
                          fontSize: 13,
                          color: const Color.fromRGBO(131, 144, 159, 1),
                          fontWeight:
                              index < 1 ? FontWeight.w500 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      lastMessage.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.rubik(
                        color: const Color.fromRGBO(131, 144, 159, 1),
                        fontWeight:
                            index < 1 ? FontWeight.w500 : FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String timeAgo(DateTime d) {
    if (DateTime.now().day == d.day) return DateFormat('HH:mm').format(d);
    String temp;
    int diff = (DateTime.now().difference(d).inHours / 24).round();
    if (diff > 2) {
      temp = DateFormat.yMMMMd().format(d);
    } else {
      temp = "Yesterday";
    }
    return temp;
  }
}
