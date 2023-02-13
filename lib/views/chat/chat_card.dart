import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatCard extends HookConsumerWidget {
  const ChatCard({
    Key? key,
    required this.chatRoom,
    required this.press,
  }) : super(key: key);

  final ChatRoom chatRoom;
  final VoidCallback press;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localUser = ref.watch(localUserProvider);
    final contactsList = ref.watch(contactsListProvider);
    return InkWell(
      onTap: press,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10 * 0.75),
        child: Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 24,
                  // backgroundImage: AssetImage(chat.image),
                ),
                if (true)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 3),
                      ),
                    ),
                  )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatRoom.userUidList[0] == localUser.uid
                          ? contactsList.singleWhere((element) => element.uid == chatRoom.userUidList[1]).name 
                          : contactsList.singleWhere((element) => element.uid == chatRoom.userUidList[0]).name ,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    const Opacity(
                      opacity: 0.64,
                      child: Text(
                        "chat.lastMessage",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Opacity(
              opacity: 0.64,
              child: Text("chat.time"),
            ),
          ],
        ),
      ),
    );
  }
}
