// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedPost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedPost _$FeedPostFromJson(Map<String, dynamic> json) => FeedPost(
      json['name'] as String,
      json['time'] as String,
      json['desc'] as String,
      json['profilePicURL'] as String,
      (json['imageUrlList'] as List<dynamic>).map((e) => e as String).toList(),
      (json['videoUrlList'] as List<dynamic>).map((e) => e as String).toList(),
      json['uid'] as String,
    );

Map<String, dynamic> _$FeedPostToJson(FeedPost instance) => <String, dynamic>{
      'name': instance.name,
      'uid': instance.uid,
      'time': instance.time,
      'desc': instance.desc,
      'profilePicURL': instance.profilePicURL,
      'imageUrlList': instance.imageUrlList,
      'videoUrlList': instance.videoUrlList,
    };
