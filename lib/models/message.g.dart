// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      time: DateTime.parse(json['time'] as String),
      text: json['text'] as String,
      sender: json['sender'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'text': instance.text,
      'sender': instance.sender,
    };
