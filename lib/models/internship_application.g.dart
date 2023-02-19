// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internship_application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InternshipApplication _$InternshipApplicationFromJson(
        Map<String, dynamic> json) =>
    InternshipApplication(
      uid: json['uid'] as String,
      coverLetter: json['coverLetter'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$InternshipApplicationToJson(
        InternshipApplication instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'coverLetter': instance.coverLetter,
      'status': instance.status,
    };
