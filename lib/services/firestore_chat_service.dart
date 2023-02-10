import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FirestoreChatService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _chatRoomsRef = _firestore.collection("ChatRooms");

  static void init() {
    _firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  static void initialiseChatRoomList(WidgetRef ref) async {
    final response =
        await _chatRoomsRef.where("userList", arrayContains: "me").get();

    final chatRooms =
        response.docs.map((e) => ChatRoom.fromJson(e.data())).toList();

    ref.read(localUserProvider.notifier).initChatRooms(chatRooms);
  }

  static Future<void> addChatRoom(ChatRoom chatRoom) async {
    await _chatRoomsRef.add(chatRoom.toJson());
  }

  static Future<void> addMessageToChatRoom(
      String chatRoomUid, Message message) async {
    await _chatRoomsRef.doc(chatRoomUid).update({
      "messages": FieldValue.arrayUnion([message.toJson()])
    });
  }

}
