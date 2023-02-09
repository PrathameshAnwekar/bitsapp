import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final String text;
  final DateTime time;
  final String sender;

  Message({
    required this.text,
    required this.sender,
    required this.time,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  /// Connect the generated [_$MessageToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  static List<Message> demoMessages = [
    Message(
      text: "Hello",
      sender: "You",
      time: DateTime.now(),
    ),
    Message(
      text: "Hello",
      sender: "me",
      time: DateTime.now(),
    ),
    Message(
      text: "Hello",
      sender: "You",
      time: DateTime.now(),
    ),
    Message(
      text: "Hello",
      sender: "me",
      time: DateTime.now(),
    ),
  ];
}
