import 'package:json_annotation/json_annotation.dart';

part 'feedPost.g.dart';

@JsonSerializable()
class FeedPost {
  /// The generated code assumes these values exist in JSON.
  final String name;
  final String uid;
  final String time;
  final String desc;
  final String profilePicURL;
  final List<String> imageUrlList;
  final List<String> videoUrlList;

  FeedPost({required this.name,required this.time,required this.desc,required this.profilePicURL,
      required this.imageUrlList,required this.videoUrlList, required this.uid});

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.
  factory FeedPost.fromJson(Map<String, dynamic> json) =>
      _$FeedPostFromJson(json);

  /// Connect the generated [_$FeedPostToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FeedPostToJson(this);
}
