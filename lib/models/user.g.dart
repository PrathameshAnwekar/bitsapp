// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['name'] as String,
      json['profilePicUrl'] as String?,
      json['email'] as String,
      json['bitsID'] as String,
      json['uid'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'profilePicUrl': instance.profilePicUrl,
      'email': instance.email,
      'bitsID': instance.bitsID,
      'uid': instance.uid,
    };
