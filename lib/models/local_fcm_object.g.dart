// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_fcm_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalFcmObjectAdapter extends TypeAdapter<LocalFcmObject> {
  @override
  final int typeId = 0;

  @override
  LocalFcmObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalFcmObject(
      token: fields[0] as String?,
      lastUpdated: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalFcmObject obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalFcmObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
