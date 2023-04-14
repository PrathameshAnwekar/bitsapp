// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      time: json['time'] as int,
      text: json['text'] as String,
      sender: json['sender'] as String,
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
      replyOf: json['replyOf'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'time': instance.time,
      'type': _$MessageTypeEnumMap[instance.type]!,
      'text': instance.text,
      'sender': instance.sender,
      'replyOf': instance.replyOf,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.video: 'video',
  MessageType.feedpost: 'feedpost',
};
