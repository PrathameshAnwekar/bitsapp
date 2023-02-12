import 'package:bitsapp/services/firestore_service.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import 'chat_room.dart';
import 'message.dart';

part 'bits_user.g.dart';

@JsonSerializable()
class BitsUser {
  /// The generated code assumes these values exist in JSON.
  final String name;
  final String? profilePicUrl;
  final String email;
  final String bitsID;
  final String uid;
  final String? fcmID;
  final List<String> chatRooms;

  BitsUser(
      {required this.name,
      required this.profilePicUrl,
      required this.email,
      required this.bitsID,
      required this.chatRooms,
      required this.uid,
      required this.fcmID});

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.
  factory BitsUser.fromJson(Map<String, dynamic> json) =>
      _$BitsUserFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BitsUserToJson(this);

  static Future<void> createNewUser(
      WidgetRef ref, UserCredential result) async {
    BitsUser bitsUser = BitsUser(
        name: result.user!.displayName!,
        profilePicUrl: null,
        email: result.user!.email!,
        bitsID: "NOT SET",
        chatRooms: [],
        uid: result.user!.uid,
        fcmID: await FirebaseMessaging.instance.getToken());
    ref.read(localUserProvider.notifier).setUser(bitsUser);
    await FirestoreService.createUser(bitsUser);
  }

  static final dummyUser1 = BitsUser(
      name: "me",
      profilePicUrl: "profilePicUrl",
      email: "email",
      bitsID: "bitsID",
      chatRooms: [],
      uid: "0",
      fcmID: "fcmID2");
  static final dummyUser2 = BitsUser(
      name: "you",
      profilePicUrl: "profilePicUrl",
      email: "email",
      bitsID: "bitsID",
      chatRooms: [],
      uid: "1",
      fcmID: "fcmID1");
}

class BitsUserNotifier extends StateNotifier<BitsUser> {
  BitsUserNotifier()
      : super(BitsUser(
            name: "name",
            profilePicUrl: "profilePicUrl",
            email: "email",
            bitsID: "bitsID",
            chatRooms: [],
            uid: "uid",
            fcmID: "fcmID"));

  void setUser(BitsUser user) {
    state = user;
  }

  void addChatRoom(ChatRoom chatRoom, String user1uid, String user2uid) {
    dlog("creating a new chatRoom for $user1uid and $user2uid");
    
    state = state..chatRooms.add(chatRoom.uid);
  }

  void initChatRoomsUidList(List<ChatRoom> chatRoomsList) {
    state = state..chatRooms.addAll(chatRoomsList.map((e) => e.uid).toList());
  }
}

final localUserProvider = StateNotifierProvider<BitsUserNotifier, BitsUser>(
    (ref) => BitsUserNotifier());

final contactsListProvider = StateProvider((ref) => List<BitsUser>.empty());
