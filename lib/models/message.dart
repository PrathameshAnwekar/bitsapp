import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final int time;
  final String text;
  final String sender;

  Message({
    required this.time,
    required this.text,
    required this.sender,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  /// Connect the generated [_$MessageToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  
}
