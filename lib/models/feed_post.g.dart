// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedPost _$FeedPostFromJson(Map<String, dynamic> json) => FeedPost(
      timeuid: json['timeuid'].toString(),
      text: json['text'].toString(),
      comments:
          (json['comments'] == null ? [] : json['comments'] as List<dynamic>)
              .map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList(),
      mediaFilesList: (json['mediaFilesList'] == null
              ? []
              : json['mediaFilesList'] as List<dynamic>)
          .map((e) => MediaFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      posterUid: json['posterUid'].toString(),
      likes: (json['likes'] == null ? [] : json['likes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FeedPostToJson(FeedPost instance) => <String, dynamic>{
      'posterUid': instance.posterUid,
      'timeuid': instance.timeuid,
      'text': instance.text,
      'mediaFilesList': instance.mediaFilesList.map((e) => e.toJson()).toList(),
      'comments': instance.comments,
      'likes': instance.likes,
    };
