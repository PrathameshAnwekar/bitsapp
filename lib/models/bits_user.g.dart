// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bits_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BitsUser _$BitsUserFromJson(Map<String, dynamic> json) => BitsUser(
      name: json['name'] as String,
      profilePicUrl: json['profilePicUrl'] as String?,
      email: json['email'] as String,
      profileDescription: json['profileDescription'] as String?,
      bitsID: json['bitsID'] as String,
      chatRooms:
          (json['chatRooms'] as List<dynamic>).map((e) => e as String).toList(),
      uid: json['uid'] as String,
      fcmID: json['fcmID'] as String?,
      appliedInternships: (json['appliedInternships'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      postedInternships: (json['postedInternships'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      feedPosts: (json['feedPosts'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      fcmToken: json['fcmToken'] as String?,
    );

Map<String, dynamic> _$BitsUserToJson(BitsUser instance) => <String, dynamic>{
      'name': instance.name,
      'profilePicUrl': instance.profilePicUrl,
      'profileDescription': instance.profileDescription,
      'email': instance.email,
      'bitsID': instance.bitsID,
      'uid': instance.uid,
      'fcmID': instance.fcmID,
      'fcmToken': instance.fcmToken,
      'chatRooms': instance.chatRooms,
      'appliedInternships': instance.appliedInternships,
      'postedInternships': instance.postedInternships,
      'feedPosts': instance.feedPosts,
    };
