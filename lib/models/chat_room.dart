import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/services/firestore_service.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:bitsapp/services/notif_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_room.g.dart';

final chatRoomsProvider =
    StateNotifierProvider<ChatRoomsNotifier, List<ChatRoom>>(
        (ref) => ChatRoomsNotifier());

@JsonSerializable()
class ChatRoom {
  final String uid;
  final List<String> userUidList;
  List<Message> messages;

  ChatRoom(
      {required this.uid, required this.userUidList, required this.messages});

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  /// Connect the generated [_$ChatRoomToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}

class ChatRoomsNotifier extends StateNotifier<List<ChatRoom>> {
  ChatRoomsNotifier() : super([]);

  void initChatRooms(List<ChatRoom> chatRooms) {
    state = chatRooms;
  }

  void updateChatRoom(String chatRoomUid, List<Message> messages) {
    state = state.map((chatRoom) {
      if (chatRoom.uid == chatRoomUid) {
        chatRoom.messages = messages;
      }
      return chatRoom;
    }).toList();
  }

  void addChatRoom(ChatRoom chatRoom, String user1uid, String user2uid) async {
    try {
      await FirestoreService.addChatRoom(chatRoom, user1uid, user2uid);
      state = state..add(chatRoom);
    } catch (e) {
      elog(e.toString());
    }
  }

  void addMessage(String chatRoomUid, Message message, String fcmUid, String senderName) async {
    try {
      await FirestoreService.addMessageToChatRoom(chatRoomUid, message);
      state = state.map((chatRoom) {
        if (chatRoom.uid == chatRoomUid) {
          chatRoom.messages = [...chatRoom.messages, message];
        }
        return chatRoom;
      }).toList();
      final sender = 
      await NotifService.sendChatNotification(
          text: message.text, sender: senderName, token: fcmUid);
    } catch (e) {
      elog(e.toString());
    }

    // await FcmService.sendChatNotification(fcmUid);
  }
}
