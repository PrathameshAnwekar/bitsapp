// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedPost _$FeedPostFromJson(Map<String, dynamic> json) => FeedPost(
      (json['mediaFilesList'] as List<dynamic>)
          .map((e) => MediaFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['posterUid'] as String,
      (json['likes'] as List<dynamic>).map((e) => e as String).toList(),
      timeuid: json['timeuid'] as String,
      text: json['text'] as String,
      comments: (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeedPostToJson(FeedPost instance) => <String, dynamic>{
      'posterUid': instance.posterUid,
      'timeuid': instance.timeuid,
      'text': instance.text,
      'mediaFilesList': instance.mediaFilesList,
      'comments': instance.comments,
      'likes': instance.likes,
    };
