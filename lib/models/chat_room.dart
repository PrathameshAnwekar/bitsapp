import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/services/firestore_service.dart';
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
    state = state..addAll(chatRooms);
  }

  void addChatRoom(ChatRoom chatRoom, String user1uid, String user2uid) async {
    state = state..add(chatRoom);
    await FirestoreService.addChatRoom(chatRoom, user1uid, user2uid);
  }

  void addMessage(String chatRoomUid, Message message) async {
    state = state.map((chatRoom) {
      if (chatRoom.uid == chatRoomUid) {
        chatRoom.messages = [...chatRoom.messages, message];
      }
      return chatRoom;
    }).toList();
    await FirestoreService.addMessageToChatRoom(chatRoomUid, message);
  }
}