// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bits_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BitsUser _$BitsUserFromJson(Map<String, dynamic> json) => BitsUser(
      name: json['name'] as String,
      profilePicUrl: json['profilePicUrl'] as String?,
      email: json['email'] as String,
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
    );

Map<String, dynamic> _$BitsUserToJson(BitsUser instance) => <String, dynamic>{
      'name': instance.name,
      'profilePicUrl': instance.profilePicUrl,
      'email': instance.email,
      'bitsID': instance.bitsID,
      'uid': instance.uid,
      'fcmID': instance.fcmID,
      'chatRooms': instance.chatRooms,
      'appliedInternships': instance.appliedInternships,
      'postedInternships': instance.postedInternships,
    };
