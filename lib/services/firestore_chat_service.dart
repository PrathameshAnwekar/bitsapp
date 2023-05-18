import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class FirestoreChatService{
    static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _chatRoomsRef = _firestore.collection("ChatRooms");
  static final _usersRef = _firestore.collection("Users");
  static final _internshipsRef = _firestore.collection("Internships");
  static final _feedPostsRef = _firestore.collection("FeedPosts");
  static final _firebaseStorage = FirebaseStorage.instance.ref();

  static Future<void> initialiseChatRooms(WidgetRef ref) async {
    try {
      await _chatRoomsRef
          .where("userUidList", arrayContains: ref.read(localUserProvider).uid)
          .get(const GetOptions(source: Source.serverAndCache))
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
}