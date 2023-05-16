import 'package:json_annotation/json_annotation.dart';

part 'user_experience.g.dart';

enum ExperienceType { education, work }

@JsonSerializable()
class UserExperience {
  final String title;
  final String description;
  final int start;
  final int end;
  final ExperienceType type;
  UserExperience({
    required this.title,
    required this.description,
    required this.start,
    required this.end,
    required this.type,
  });

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.
  factory UserExperience.fromJson(Map<String, dynamic> json) =>
      _$UserExperienceFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserExperienceToJson(this);
}
