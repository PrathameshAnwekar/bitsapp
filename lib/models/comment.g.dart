// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      posterUid: json['posterUid'] as String,
      text: json['text'] as String,
      timeUid: json['timeUid'] as int,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'posterUid': instance.posterUid,
      'text': instance.text,
      'timeUid': instance.timeUid,
    };
