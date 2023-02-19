import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/models/internship_application.dart';
import 'package:bitsapp/models/internship_data.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _chatRoomsRef = _firestore.collection("ChatRooms");
  static final _usersRef = _firestore.collection("Users");
  static final _internshipsRef = _firestore.collection("Internships");
  static void init() {
    try {
      _firestore.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );
    } catch (e) {
      elog(e.toString());
    }
  }

  static Future<void> initUser(WidgetRef ref) async {
    try {
      await FirestoreService.updateContactsList(ref);
      await FirestoreService.initialiseChatRooms(ref);
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final userDoc = await _usersRef.doc(uid).get();
      final user = BitsUser.fromJson(userDoc.data()!);

      ref.read(localUserProvider.notifier).setUser(user);
    } catch (e) {
      elog(e.toString());
    }
  }

  static Future<void> createUser(BitsUser user) async {
    try {
      await _usersRef.doc(user.uid).set(user.toJson());
    } catch (e) {
      elog(e.toString());
    }
  }

  static Future<void> updateContactsList(WidgetRef ref) async {
    try {
      final response = await _usersRef.get();
      final allUsersList = response.docs.map((e) {
        final profile = e.data();
        return BitsUser.fromJson(profile);
      }).toList();

      ref.read(contactsListProvider.notifier).state = allUsersList;
      dlog("initialised ${allUsersList.length} contacts");
    } catch (e) {
      elog(e.toString());
    }
  }

  static Future<void> initialiseChatRooms(WidgetRef ref) async {
    try {
      await _chatRoomsRef
          .where("userUidList", arrayContains: ref.read(localUserProvider).uid)
          .get()
          .then((value) {
        final chatRooms =
            value.docs.map((e) => ChatRoom.fromJson(e.data())).toList();

        ref.read(localUserProvider.notifier).initChatRoomsUidList(chatRooms);
        ref.read(chatRoomsProvider.notifier).initChatRooms(chatRooms);
        dlog("initialised ${chatRooms.length} chat rooms");
      });
    } catch (e) {
      elog(e.toString());
    }
  }

  static Future<void> addChatRoom(
      ChatRoom chatRoom, String user1uid, String user2uid) async {
    try {
      await _chatRoomsRef.doc(chatRoom.uid).set(chatRoom.toJson());
      await _usersRef.doc(user1uid).update({
        "chatRooms": FieldValue.arrayUnion([chatRoom.uid])
      });
      await _usersRef.doc(user2uid).update({
        "chatRooms": FieldValue.arrayUnion([chatRoom.uid])
      });
    } catch (e) {
      elog(e.toString());
    }
  }

  static Future<void> addMessageToChatRoom(
      String chatRoomUid, Message message) async {
    try {
      await _chatRoomsRef.doc(chatRoomUid).update({
        "messages": FieldValue.arrayUnion([message.toJson()])
      });
      dlog("added message ${message.text} to chat room $chatRoomUid");
    } catch (e) {
      elog(e.toString());
    }
  }

  static Future<void> addInternship(InternshipData internshipData) async {
    await _internshipsRef.doc(internshipData.uid).set(internshipData.toJson());
  }

  static Future<void> updateInternship(InternshipData internshipData) async {
    await _internshipsRef
        .doc(internshipData.uid)
        .update(internshipData.toJson());
  }

  static Future<void> deleteInternship(String internshipUid) async {
    await _internshipsRef.doc(internshipUid).delete();
  }

  static Future<void> addInternshipApplication(
      String internshipUid, InternshipApplication internshipApplication) async {
    await _internshipsRef.doc(internshipUid).update({
      "applications": FieldValue.arrayUnion([internshipApplication.toJson()])
    });
  }
}
