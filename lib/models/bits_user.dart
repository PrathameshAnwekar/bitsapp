import 'package:bitsapp/models/user_experience.dart';
import 'package:bitsapp/services/firestore_profile_service.dart';
import 'package:bitsapp/services/firestore_service.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import 'chat_room.dart';

part 'bits_user.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class BitsUser extends HiveObject {
  /// The generated code assumes these values exist in JSON.
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String? profilePicUrl;
  final String? profileDescription;
  final String email;
  final String bitsID;
  @HiveField(2)
  final String uid;
  final String? fcmID;
  @HiveField(3)
  final String? fcmToken;
  final List<String> chatRooms;
  final List<String>? appliedInternships;
  final List<String>? postedInternships;
  final List<String>? feedPosts;
  final String? resumeLink;
  final List<UserExperience>? userExperience;
  final bool? chatBarrier;
  BitsUser({
    required this.name,
    required this.profilePicUrl,
    required this.email,
    required this.profileDescription,
    required this.bitsID,
    required this.chatRooms,
    required this.uid,
    required this.fcmID,
    required this.appliedInternships,
    required this.postedInternships,
    required this.feedPosts,
    required this.fcmToken,
    required this.resumeLink,
    required this.userExperience,
    required this.chatBarrier
  });

  factory BitsUser.fromJson(Map<String, dynamic> json) =>
      _$BitsUserFromJson(json);

  Map<String, dynamic> toJson() => _$BitsUserToJson(this);

  static Future<void> createNewUser(
      WidgetRef ref, UserCredential result) async {
    String name = properCase(result.user!.displayName ?? "name");

    BitsUser bitsUser = BitsUser(
      name: name,
      profilePicUrl: null,
      email: result.user!.email!,
      profileDescription: "BITSian",
      bitsID: "NOT SET",
      chatRooms: [],
      uid: result.user!.uid,
      fcmID: await FirebaseMessaging.instance.getToken(),
      appliedInternships: [],
      postedInternships: [],
      feedPosts: [],
      fcmToken: "NOT SET",
      resumeLink: null,
      userExperience: [],
      chatBarrier: false
    );
    ref.read(localUserProvider.notifier).setUser(bitsUser);
    await FirestoreProfileService.createUser(bitsUser);
  }

  static BitsUser dummy = BitsUser(
    name: "Someone",
    profilePicUrl: null,
    email: "email",
    profileDescription: "Someone",
    bitsID: "bitsID",
    chatRooms: [],
    uid: "uid",
    fcmID: "fcmID",
    appliedInternships: [],
    postedInternships: [],
    feedPosts: [],
    fcmToken: "fcmToken",
    resumeLink: null,
    userExperience: [],
    chatBarrier: false
  );
}

class BitsUserNotifier extends StateNotifier<BitsUser> {
  BitsUserNotifier()
      : super(BitsUser(
            name: "name",
            profilePicUrl: "profilePicUrl",
            profileDescription: "profileDescription",
            email: "email",
            bitsID: "bitsID",
            chatRooms: [],
            uid: "uid",
            fcmID: "fcmID",
            appliedInternships: [],
            postedInternships: [],
            fcmToken: "",
            feedPosts: [],
            resumeLink: null,
            userExperience: [], 
            chatBarrier: false));

  void setUser(BitsUser user) {
    state = user;
  }

  void addChatRoom(String uid) {
    dlog("creating a new chatRoom for uid $uid");

    state = state..chatRooms.add(uid);
  }

  void initChatRoomsUidList(List<ChatRoom> chatRoomsList) {
    state = state..chatRooms.addAll(chatRoomsList.map((e) => e.uid).toList());
  }

  Future<void> addInternshipApplication(String internshipUid) async {
    try {
      state = state..appliedInternships!.add(internshipUid);
    } catch (e) {
      elog(e.toString());
    }
  }

  void clearUser() {
    state = BitsUser(
        name: "name",
        profilePicUrl: "profilePicUrl",
        profileDescription: "profileDescription",
        email: "email",
        bitsID: "bitsID",
        chatRooms: [],
        uid: "uid",
        fcmID: "fcmID",
        appliedInternships: [],
        postedInternships: [],
        fcmToken: "",
        feedPosts: [],
        resumeLink: null,
        userExperience: [],
        chatBarrier: false);
  }
}

final localUserProvider = StateNotifierProvider<BitsUserNotifier, BitsUser>(
    (ref) => BitsUserNotifier());

final contactsListProvider = StateProvider((ref) => List<BitsUser>.empty());

//function to properly capitalise the name
String properCase(String s) {
  String proper = s[0].toUpperCase();
  for (int i = 1; i < s.length; i++) {
    if (s[i - 1] == ' ') {
      proper += s[i].toUpperCase();
    } else {
      proper += s[i].toLowerCase();
    }
  }
  return proper;
}
