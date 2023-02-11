import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_room.g.dart';


@JsonSerializable()
class ChatRoom {
  final String uid;
  final List<String> userUidList;
  final List<Message> messages;

  ChatRoom({required this.uid, required this.userUidList, required this.messages});

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  /// Connect the generated [_$ChatRoomToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);

  static List chatsData = [
    ChatRoom(
      uid: "Jenny Wilson",
      userUidList: [BitsUser.dummyUser1.uid, BitsUser.dummyUser2.uid],
      messages: Message.demoMessages,
    ),
    ChatRoom(
      uid: "Esther Howard",
      userUidList: [BitsUser.dummyUser1.uid, BitsUser.dummyUser2.uid],
      messages: Message.demoMessages,
    ),
    ChatRoom(
      uid: "Ralph Edwards",
      userUidList: [BitsUser.dummyUser1.uid, BitsUser.dummyUser2.uid],
      messages: Message.demoMessages,
    ),
    ChatRoom(
      uid: "Jacob Jones",
      userUidList: [BitsUser.dummyUser1.uid, BitsUser.dummyUser2.uid],
      messages: Message.demoMessages,
    ),
    ChatRoom(
      uid: "Albert Flores",
      userUidList: [BitsUser.dummyUser1.uid, BitsUser.dummyUser2.uid],
      messages: Message.demoMessages,
    ),
    ChatRoom(
      uid: "Jenny Wilson",
      userUidList: [BitsUser.dummyUser1.uid, BitsUser.dummyUser2.uid],
      messages: Message.demoMessages,
    ),
    ChatRoom(
      uid: "Esther Howard",
      userUidList: [BitsUser.dummyUser1.uid, BitsUser.dummyUser2.uid],
      messages: Message.demoMessages,
    ),
    ChatRoom(
      uid: "Ralph Edwards",
      userUidList: [BitsUser.dummyUser1.uid, BitsUser.dummyUser2.uid],
      messages: Message.demoMessages,
    ),
  ];
}

