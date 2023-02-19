
import 'package:json_annotation/json_annotation.dart';

part 'internship_application.g.dart';

@JsonSerializable()
class InternshipApplication {
  final String uid;
  final String coverLetter;
  final String status;

  InternshipApplication({
    required this.uid,
    required this.coverLetter,
    required this.status,
  });

  factory InternshipApplication.fromJson(Map<String, dynamic> json) =>
      _$InternshipApplicationFromJson(json);

  /// Connect the generated [_$InternshipApplicationToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$InternshipApplicationToJson(this);
}
