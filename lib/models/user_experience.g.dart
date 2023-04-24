// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_experience.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserExperience _$UserExperienceFromJson(Map<String, dynamic> json) =>
    UserExperience(
      title: json['title'] as String,
      description: json['description'] as String,
      start: json['start'] as int,
      end: json['end'] as int,
      type: $enumDecode(_$ExperienceTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$UserExperienceToJson(UserExperience instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'start': instance.start,
      'end': instance.end,
      'type': _$ExperienceTypeEnumMap[instance.type]!,
    };

const _$ExperienceTypeEnumMap = {
  ExperienceType.education: 'education',
  ExperienceType.work: 'work',
};
