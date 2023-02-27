
import 'package:json_annotation/json_annotation.dart';


part 'comment.g.dart';

@JsonSerializable()
class Comment {
  String posterUid;
  String text;
  int timeUid;

  Comment({required this.posterUid, required this.text, required this.timeUid});

    factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  /// Connect the generated [_$CommentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
