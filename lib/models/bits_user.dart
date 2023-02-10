import 'package:bitsapp/services/firestore_chat_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import 'chat_room.dart';
import 'message.dart';

part 'bits_user.g.dart';

final localUserProvider = StateNotifierProvider<BitsUserNotifier, BitsUser>(
    (ref) => BitsUserNotifier());

@JsonSerializable()
class BitsUser {
  /// The generated code assumes these values exist in JSON.
  final String name;
  final String? profilePicUrl;
  final String email;
  final String bitsID;
  final String uid;
  final String fcmID;
  final List<ChatRoom> chatRooms;

  BitsUser(
      {required this.name,
      required this.profilePicUrl,
      required this.email,
      required this.bitsID,
      required this.chatRooms,
      required this.uid,
      required this.fcmID});

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.
  factory BitsUser.fromJson(Map<String, dynamic> json) =>
      _$BitsUserFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BitsUserToJson(this);

  static final dummyUser1 = BitsUser(
      name: "me",
      profilePicUrl: "profilePicUrl",
      email: "email",
      bitsID: "bitsID",
      chatRooms: [],
      uid: "0",
      fcmID: "fcmID2");
  static final dummyUser2 = BitsUser(
      name: "you",
      profilePicUrl: "profilePicUrl",
      email: "email",
      bitsID: "bitsID",
      chatRooms: [],
      uid: "1",
      fcmID: "fcmID1");
}

class BitsUserNotifier extends StateNotifier<BitsUser> {
  BitsUserNotifier()
      : super(BitsUser(
            name: "name",
            profilePicUrl: "profilePicUrl",
            email: "email",
            bitsID: "bitsID",
            chatRooms: [],
            uid: "uid",
            fcmID: "fcmID"));

  void setUser(BitsUser user) {
    state = user;
  }

  void addChatRoom(ChatRoom chatRoom) {
    state = state..chatRooms.add(chatRoom);
  }

  void removeChatRoom(ChatRoom chatRoom) {
    state = state..chatRooms.remove(chatRoom);
  }

  void updateChatRoom(ChatRoom chatRoom) {
    state = state..chatRooms[state.chatRooms.indexOf(chatRoom)] = chatRoom;
  }

  void initChatRooms(List<ChatRoom> chatRoomsList) {
    state = state..chatRooms.addAll(chatRoomsList);
  }

  void addMessage(ChatRoom chatRoom, Message message) {
    state = state
      ..chatRooms.map((element) {
        if (element.uid == chatRoom.uid) {
          FirestoreChatService.addMessageToChatRoom(chatRoom.uid, message);
          return ChatRoom(
            uid: element.uid,
            userList: element.userList,
            messages: [...element.messages, message],
          );
        } else {
          return element;
        }
      }).toList();
  }
}
