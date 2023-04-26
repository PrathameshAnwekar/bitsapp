//use firestore documents to implement chat channel
import 'package:bitsapp/models/message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_channel.g.dart';

@JsonSerializable()
class ChatChannel {
  final String name;
  final List<Message> messages;
  final Message lastMessage;
  ChatChannel(
      {required this.name, required this.messages, required this.lastMessage});

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.
  factory ChatChannel.fromJson(Map<String, dynamic> json) =>
      _$ChatChannelFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ChatChannelToJson(this);
}
