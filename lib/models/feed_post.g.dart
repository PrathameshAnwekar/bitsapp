// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedPost _$FeedPostFromJson(Map<String, dynamic> json) => FeedPost(
      (json['mediaFilesList'] as List<dynamic>)
          .map((e) => MediaFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String,
      time: json['time'] as String,
      desc: json['desc'] as String,
      profilePicURL: json['profilePicURL'] as String,
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$FeedPostToJson(FeedPost instance) => <String, dynamic>{
      'name': instance.name,
      'uid': instance.uid,
      'time': instance.time,
      'desc': instance.desc,
      'profilePicURL': instance.profilePicURL,
      'mediaFilesList': instance.mediaFilesList,
    };
