import 'package:json_annotation/json_annotation.dart';

part 'media_file.g.dart';

@JsonSerializable()
class MediaFile {
  final String type;
  final String url;

  MediaFile( {
   required this.type, required this.url,
  });

  factory MediaFile.fromJson(Map<String, dynamic> json) =>
      _$MediaFileFromJson(json);

  /// Connect the generated [_$MediaFileToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MediaFileToJson(this);

  
}
