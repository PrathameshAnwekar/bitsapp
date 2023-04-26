// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatChannel _$ChatChannelFromJson(Map<String, dynamic> json) => ChatChannel(
      name: json['name'] as String,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastMessage:
          Message.fromJson(json['lastMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatChannelToJson(ChatChannel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'messages': instance.messages,
      'lastMessage': instance.lastMessage,
    };
