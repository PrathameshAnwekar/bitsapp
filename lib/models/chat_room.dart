import 'package:bitsapp/models/message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_room.g.dart';

@JsonSerializable()
class ChatRoom {
  final String uid;
  final List<Message> messages;

  ChatRoom({required this.uid, required this.messages});

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  /// Connect the generated [_$ChatRoomToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);


 static List chatsData = [
  ChatRoom(
    uid: "Jenny Wilson",
  messages: Message.demoMessages,
  ),
  ChatRoom(
    uid: "Esther Howard",
 messages: Message.demoMessages,
  ),
  ChatRoom(
    uid: "Ralph Edwards",
 messages: Message.demoMessages,
  ),
  ChatRoom(
    uid: "Jacob Jones",
 messages: Message.demoMessages,
  ),
  ChatRoom(
    uid: "Albert Flores",
 messages: Message.demoMessages,
  ),
  ChatRoom(
    uid: "Jenny Wilson",
 messages: Message.demoMessages,
  ),
  ChatRoom(
    uid: "Esther Howard",
 messages: Message.demoMessages,
  ),
  ChatRoom(
    uid: "Ralph Edwards",
 messages: Message.demoMessages,
  ),
];
}
