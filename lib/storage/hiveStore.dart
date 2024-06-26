import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/local_fcm_object.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final hiveP = StateProvider((ref) => null);

class HiveStore {
  static final storage = Hive.box("defaultStorage");
  static final chatRooms = Hive.box("chatStorage");
  static final bookmarkedPosts = Hive.box("bookmarkedPosts");
  static final contactsStorage = Hive.box("contactsStorage");
  static final savedPostsStorage = Hive.box("savedPostsStorage");
  static final notificationStorage = Hive.box("notificationStorage");
  static init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init((await getApplicationDocumentsDirectory()).path);
    Hive
      ..initFlutter(appDocumentDirectory.path)
      ..registerAdapter(LocalFcmObjectAdapter());
    Hive
      ..initFlutter(appDocumentDirectory.path)
      ..registerAdapter(BitsUserAdapter());

    await Hive.openBox("defaultStorage");
    await Hive.openBox("chatStorage");
    await Hive.openBox("bookmarkedPosts");
    await Hive.openBox("contactsStorage");
    await Hive.openBox("savedPostsStorage");
    await Hive.openBox("notificationStorage");
  }

  static Future<void> saveUserToStorage(BitsUser user) async {

    await contactsStorage.put(user.uid, user);
  }

  static BitsUser? getUserFromStorage({required String uid}) {
    // print(contactsStorage.get(uid).name);
    return contactsStorage.get(uid);
  }

  static Future<void> storeAllUsersToStorage(List<BitsUser> users) async {
    if(!contactsStorage.isOpen) await Hive.openBox("contactsStorage");
    for (int i = 0; i < users.length; i++) {
      print(users[i].name);
      
      await saveUserToStorage(users[i]);
    }
  }
}
