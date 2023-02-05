// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedPost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedPost _$FeedPostFromJson(Map<String, dynamic> json) => FeedPost(
      name: json['name'] as String,
      time: json['time'] as String,
      desc: json['desc'] as String,
      profilePicURL: json['profilePicURL'] as String,
      imageUrlList: (json['imageUrlList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      videoUrlList: (json['videoUrlList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      uid: json['uid'] as String,
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
