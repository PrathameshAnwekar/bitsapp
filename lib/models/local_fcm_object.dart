import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class LocalFcmObject {
  @HiveField(0)
  String? token;
  @HiveField(1)
  int? lastUpdated;
  LocalFcmObject({required this.token, required this.lastUpdated});
}

class LocalFcmObjectAdapter extends TypeAdapter<LocalFcmObject>{

  @override
  LocalFcmObject read(BinaryReader reader) {
    return LocalFcmObject(
      token: reader.read(),
      lastUpdated: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, LocalFcmObject obj) {
    writer.write(obj.token);
    writer.write(obj.lastUpdated);
  }
  
  @override
  int get typeId => 0;
}