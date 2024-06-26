import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../storage/hiveStore.dart';
import 'components/body.dart';
import 'components/chat_app_bar.dart';

class ChatRoomScreen extends HookConsumerWidget {
  static const routeName = "/chat-room-creen";
  final String chatRoomUid;

  const ChatRoomScreen({super.key, required this.chatRoomUid});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRoom = ref
        .watch(chatRoomsProvider)
        .firstWhere((element) => element.uid == chatRoomUid);
    final otherUser =
        (chatRoom.userUidList[0] == ref.read(localUserProvider).uid
                ? HiveStore.getUserFromStorage(uid: chatRoom.userUidList[1])
                : HiveStore.getUserFromStorage(uid: chatRoom.userUidList[0])) ??
            BitsUser.dummy;
    return WillPopScope(
      onWillPop: () {
        ref.read(replyOfMessageProvider.notifier).state = null;
        
        return Future.value(true);
      },
      child: Scaffold(
        appBar: ChatAppBar(otherUser: otherUser),
        body: Body(
          chatRoomUid: chatRoomUid,
          receiver: otherUser,
        ),
        backgroundColor: Constants.kSecondaryColor,
      ),
    );
  }
}

final chatStreamProvider =
    StreamProvider.family<dynamic, String>((ref, chatRoomUid) async* {
  final chatStream = FirebaseFirestore.instance
      .collection("ChatRooms")
      .doc(chatRoomUid)
      .snapshots();

  ref.onDispose(() {
    chatStream.drain();
  });

  await for (final value in chatStream) {
    if (value.data() != null) {
      final chatRoom = ChatRoom.fromJson(value.data()!);
      vlog("chatRoom: ${chatRoom.toJson()}");
      ref
          .read(chatRoomsProvider.notifier)
          .updateChatRoom(chatRoomUid, chatRoom.messages);
    }
    yield value;
  }
});

//Using these instead of hooks to avoid rebuilding the whole screen
final replyOfMessageProvider = StateProvider.autoDispose<Message?>((ref) => null);
