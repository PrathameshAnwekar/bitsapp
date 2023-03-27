import 'package:bitsapp/models/local_fcm_object.dart';
import 'package:bitsapp/services/fcm_service.dart';
import 'package:path_provider/path_provider.dart';

import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final hiveP = StateProvider((ref) => null);

class HiveStore {
  static final storage = Hive.box("defaultStorage");
  static final chatRooms = Hive.box("chatStorage");
  static final bookmarkedPosts = Hive.box("bookmarkedPosts");

  static init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive
    ..init(appDocumentDirectory.path)
    ..registerAdapter(LocalFcmObjectAdapter());
    
    await Hive.openBox("defaultStorage");
    await Hive.openBox("chatStorage");
    await Hive.openBox("bookmarkedPosts");
  }
}
