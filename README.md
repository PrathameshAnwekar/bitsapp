# bitsapp

## Important
### JsonSerializable Bug
Use this line === 'mediaFilesList': instance.mediaFilesList.map((e) => e.toJson()).toList() === in lib/models/feedpost.g.dart to avoid bugs after you use the "flutter pub run build_runner build command"
