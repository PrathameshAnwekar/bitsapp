// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bits_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BitsUserAdapter extends TypeAdapter<BitsUser> {
  @override
  final int typeId = 1;

  @override
  BitsUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BitsUser(
      name: fields[0] as String,
      profilePicUrl: fields[1] as String?,
      uid: fields[2] as String,
      fcmToken: fields[3] as String?,
      //rest of these fields are not needed for most things in the app
      appliedInternships: [],
      bitsID: '',
      chatRooms: [],
      email: '',
      fcmID: '',
      feedPosts: [],
      postedInternships: [],
      profileDescription: '',
    );
  }

  @override
  void write(BinaryWriter writer, BitsUser obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.profilePicUrl)
      ..writeByte(2)
      ..write(obj.uid)
      ..writeByte(3)
      ..write(obj.fcmToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BitsUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
