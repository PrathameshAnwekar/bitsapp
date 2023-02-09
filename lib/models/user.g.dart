// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      profilePicUrl: json['profilePicUrl'] as String?,
      email: json['email'] as String,
      bitsID: json['bitsID'] as String,
      uid: json['uid'] as String,
      fcmID: json['fcmID'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'profilePicUrl': instance.profilePicUrl,
      'email': instance.email,
      'bitsID': instance.bitsID,
      'uid': instance.uid,
      'fcmID': instance.fcmID,
    };
