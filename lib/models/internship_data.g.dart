// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internship_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InternshipData _$InternshipDataFromJson(Map<String, dynamic> json) =>
    InternshipData(
      uid: json['uid'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      applicantUIDandCoverLetter:
          (json['applicantUIDandCoverLetter'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      posterUID: json['posterUID'] as String,
      time: json['time'] as int,
      skills: json['skills'] as String,
      contactEmail: json['contactEmail'] as String?,
      compensation: json['compensation'] as String,
    );

Map<String, dynamic> _$InternshipDataToJson(InternshipData instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'description': instance.description,
      'posterUID': instance.posterUID,
      'time': instance.time,
      'skills': instance.skills,
      'contactEmail': instance.contactEmail,
      'compensation': instance.compensation,
      'applicantUIDandCoverLetter': instance.applicantUIDandCoverLetter,
    };
