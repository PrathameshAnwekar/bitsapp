part of 'local_fcm_object.dart';

class LocalFcmObjectAdapter extends TypeAdapter<LocalFcmObject> {
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
