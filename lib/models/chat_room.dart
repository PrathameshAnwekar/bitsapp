import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_room.g.dart';


@JsonSerializable()
class ChatRoom {
  final String uid;
  final List<BitsUser> userList;
  final List<Message> messages;

  ChatRoom({required this.uid, required this.userList, required this.messages});

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  /// Connect the generated [_$ChatRoomToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);

  static List chatsData = [
    ChatRoom(
      uid: "Jenny Wilson",
      userList: [BitsUser.dummyUser1, BitsUser.dummyUser2],
      messages: Message.demoMessages,
    ),
    ChatRoom(
      uid: "Esther Howard",
      userList: [BitsUser.dummyUser1, BitsUser.dummyUser2],
      messages: Message.demoMessages,
    ),
    ChatRoom(
      uid: "Ralph Edwards",
      userList: [BitsUser.dummyUser1, BitsUser.dummyUser2],
      messages: Message.demoMessages,
    ),
    ChatRoom(
      uid: "Jacob Jones",
      userList: [BitsUser.dummyUser1, BitsUser.dummyUser2],
      messages: Message.demoMessages,
    ),
    ChatRoom(
      uid: "Albert Flores",
      userList: [BitsUser.dummyUser1, BitsUser.dummyUser2],
      messages: Message.demoMessages,
    ),
    ChatRoom(
      uid: "Jenny Wilson",
      userList: [BitsUser.dummyUser1, BitsUser.dummyUser2],
      messages: Message.demoMessages,
    ),
    ChatRoom(
      uid: "Esther Howard",
      userList: [BitsUser.dummyUser1, BitsUser.dummyUser2],
      messages: Message.demoMessages,
    ),
    ChatRoom(
      uid: "Ralph Edwards",
      userList: [BitsUser.dummyUser1, BitsUser.dummyUser2],
      messages: Message.demoMessages,
    ),
  ];
}

