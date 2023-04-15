# bitsapp

## Important Notes
### JsonSerializable Bug
Use this line === 'mediaFilesList': instance.mediaFilesList.map((e) => e.toJson()).toList() === in lib/models/feedpost.g.dart to avoid bugs after you use the "flutter pub run build_runner build command"

### FirebaseAuth Stream
Do not use the FirebaseAuth stream for listening to auth state changes in the MyApp widget. It leads to a bug where the AuthController.signIn() is disposed before completion, leading to data not being updated.