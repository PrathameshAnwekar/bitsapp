import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  /// The generated code assumes these values exist in JSON.
  final String name;
  final String? profilePicUrl;
  final String email;
  final String bitsID;
  final String uid;
  final String fcmID;
  User(
      {required this.name,
      required this.profilePicUrl,
      required this.email,
      required this.bitsID,
      required this.uid,
      required this.fcmID});

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
