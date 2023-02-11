import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _chatRoomsRef = _firestore.collection("ChatRooms");
  static final _usersRef = _firestore.collection("Users");

  static void init() {
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  static void initUser(WidgetRef ref) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final userDoc = await _usersRef.doc(uid).get();
    final user = BitsUser.fromJson(userDoc.data()!);
    ref.read(localUserProvider.notifier).setUser(user);
  }

  static Future<void> createUser(BitsUser user) async {
    await _usersRef.doc(user.uid).set(user.toJson());
  }

  static updateContactsList(WidgetRef ref) async {
    final response = await _usersRef.get();
    final allUsersList = response.docs.map((e) {
      final profile = e.data();
      return BitsUser.fromJson(profile);
    }).toList();
    ref.read(contactsListProvider.notifier).state = allUsersList;
  }

  static void initialiseChatRoomList(WidgetRef ref) async {
    final response =
        await _chatRoomsRef.where("userList", arrayContains: "me").get();

    final chatRooms =
        response.docs.map((e) => ChatRoom.fromJson(e.data())).toList();

    ref.read(localUserProvider.notifier).initChatRooms(chatRooms);
  }

  static Future<void> addChatRoom(
      ChatRoom chatRoom, String user1uid, String user2uid) async {
    await _chatRoomsRef.add(chatRoom.toJson());
    await _usersRef.doc(user1uid).update({
      "chatRooms": FieldValue.arrayUnion([chatRoom.uid])
    });
    await _usersRef.doc(user2uid).update({
      "chatRooms": FieldValue.arrayUnion([chatRoom.uid])
    });
  }

  static Future<void> addMessageToChatRoom(
      String chatRoomUid, Message message) async {
    await _chatRoomsRef.doc(chatRoomUid).update({
      "messages": FieldValue.arrayUnion([message.toJson()])
    });
  }
}
