import 'package:hive/hive.dart';

part 'local_fcm_object.g.dart';
@HiveType(typeId: 0)
class LocalFcmObject {
  @HiveField(0)
  String? token;
  @HiveField(1)
  int? lastUpdated;
  LocalFcmObject({required this.token, required this.lastUpdated});
}

