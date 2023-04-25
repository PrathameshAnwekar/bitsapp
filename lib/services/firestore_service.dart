import 'dart:io';

import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/models/comment.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/models/internship_application.dart';
import 'package:bitsapp/models/internship_data.dart';
import 'package:bitsapp/models/media_file.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:bitsapp/services/notif_service.dart';
import 'package:bitsapp/storage/hiveStore.dart';
import 'package:bitsapp/views/auth/auth_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _chatRoomsRef = _firestore.collection("ChatRooms");
  static final _usersRef = _firestore.collection("Users");
  static final _internshipsRef = _firestore.collection("Internships");
  static final _feedPostsRef = _firestore.collection("FeedPosts");
  static final _firebaseStorage = FirebaseStorage.instance.ref();
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

  static Future<bool> initEverything(
      WidgetRef ref, BuildContext context) async {
    try {
      await FirestoreService.initUser(ref, context);
      dlog("User initialised");
      await FirestoreService.updateContactsList(ref).then((value) async {
        dlog("Contacts list updated");
        await FirestoreService.initInternshipData(ref);
        dlog("Internship data initialised");
        await FirestoreService.initialiseChatRooms(ref);
        dlog("Chat rooms initialised");
        await FirestoreService.initFeedPosts(ref);
      });
      return Future.value(true);
    } catch (e) {
      elog(e.toString());
      return Future.value(false);
    }
  }

  // ************* USER SERVICES ************* //
  static Future<void> initUser(WidgetRef ref, BuildContext context) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      final userDoc = await _usersRef
          .doc(uid)
          .get(const GetOptions(source: Source.serverAndCache));
      final user = BitsUser.fromJson(userDoc.data()!);

      ref.read(localUserProvider.notifier).setUser(user);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("You've been logged out, please log in again.")));
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AuthScreen.routeName, (route) => false);
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
      //get documents order by "name" field in each document
      final response = await _usersRef
          .orderBy(FieldPath(const ["name"]))
          .get(const GetOptions(source: Source.serverAndCache));
      final allUsersList = response.docs.map((e) {
        final profile = e.data();
        return BitsUser.fromJson(profile);
      }).toList();
      allUsersList.removeWhere((e) => e.uid == ref.read(localUserProvider).uid );
      ref.read(contactsListProvider.notifier).state = allUsersList;
      await HiveStore.storeAllUserToStorage(allUsersList);
      dlog("initialised ${allUsersList.length} contacts");
    } catch (e) {
      elog(e.toString());
    }
  }

  // ************* CHAT ROOM SERVICES ************* //
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

  // ************* iNTERNSHIP SERVICES ************* //
  static Future<void> postInternship(
      InternshipData internshipData, String localUserUid) async {
    await _internshipsRef.doc(internshipData.uid).set(internshipData.toJson());
    await _usersRef.doc(localUserUid).set({
      "postedInternships": FieldValue.arrayUnion([internshipData.uid])
    }, SetOptions(merge: true));
  }

  static Future<void> updateInternship(InternshipData internshipData) async {
    await _internshipsRef
        .doc(internshipData.uid)
        .update(internshipData.toJson());
  }

  static Future<void> deleteInternship(String internshipUid) async {
    await _internshipsRef.doc(internshipUid).delete();
  }

  static Future<void> addInternshipApplication(String internshipUid,
      InternshipApplication internshipApplication, String localUserUid) async {
    await _internshipsRef.doc(internshipUid).set({
      "applications": FieldValue.arrayUnion([internshipApplication.toJson()])
    }, SetOptions(merge: true));
    _usersRef.doc(localUserUid).set({
      "appliedInternships": FieldValue.arrayUnion([internshipUid])
    }, SetOptions(merge: true));
  }

  static Future<void> initInternshipData(WidgetRef ref) async {
    await _internshipsRef
        .get(const GetOptions(source: Source.serverAndCache))
        .then((value) {
      final internships =
          value.docs.map((e) => InternshipData.fromJson(e.data())).toList();
      ref
          .read(internshipDataProvider.notifier)
          .initInternshipsData(internships);
      dlog("initialised ${internships.length} internships");
    });
  }

  static Future<void> updateInternshipApplicationStatus(
      InternshipApplication application,
      InternshipData internship,
      String status) async {
    try {
      _internshipsRef.doc(internship.uid).update({
        "applications": FieldValue.arrayRemove([application.toJson()]),
      });

      application.status = status;
      _internshipsRef.doc(internship.uid).update({
        "applications": FieldValue.arrayUnion([application.toJson()]),
      });
    } catch (e) {
      elog(e.toString());
    }
  }

  // ************* FIREBASEMESSAGING SERVICES ************* //
  static updateFcmToken(String token) async {
    await _usersRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"fcmToken": token});
  }

  // ************* FEED POST SERVICES ************* //

  static Future<void> initFeedPosts(WidgetRef ref) async {
    //get last 10 posts
    await _feedPostsRef
        .orderBy("timeuid", descending: true)
        .limit(10)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((value) {
      final posts = value.docs.map((e) => FeedPost.fromJson(e.data())).toList();
      ref.read(feedPostDataProvider.notifier).initFeedPostsData(posts);
      dlog("initialised ${posts.length} posts");
    });
  }

  static Future<void> fetchExtra10FeedPosts(WidgetRef ref) async {
    //get 10 more posts
    final feedPosts = ref.read(feedPostDataProvider);
    await _feedPostsRef
        .orderBy("timeuid", descending: true)
        .startAfter([feedPosts[feedPosts.length - 1].timeuid])
        .limit(10)
        .get(const GetOptions(source: Source.serverAndCache))
        .then((value) {
          final posts =
              value.docs.map((e) => FeedPost.fromJson(e.data())).toList();
          ref.read(feedPostDataProvider.notifier).addExtraFeedPosts(posts);
          dlog("added ${posts.length} posts");
        });
  }

  static Future<void> addFeedPost(
      FeedPost feedPost, Map<File, String> files, WidgetRef ref) async {
    //upload files list and get urls in a list
    try {
      int i = 0;
      for (var file in files.keys) {
        vlog("UploadTaskFlow: uploading ${files[file]}");
        final url = await _firebaseStorage
            .child("feedPosts/${feedPost.posterUid}/${feedPost.timeuid}-$i")
            .putFile(file)
            .then((value) => value.ref.getDownloadURL());
        i++;
        vlog("UploadTaskFlow: uploaded ${files[file]} $i. url : $url");

        feedPost.mediaFilesList.add(MediaFile(type: files[file]!, url: url));
        vlog("UploadTaskFlow: added ${files[file]} to mediaFilesList");
      }
      await _feedPostsRef.doc(feedPost.timeuid).set(feedPost.toJson());
      ref.read(feedPostDataProvider.notifier).addFeedPost(feedPost);
      final senderName = ref
          .read(contactsListProvider)
          .where((element) => element.uid == feedPost.posterUid)
          .first
          .name;
      await NotifService.sendPostNotification(
          sender: senderName, text: feedPost.text);
    } catch (e) {
      elog(e.toString());
      rethrow;
    }
  }

  static Future<void> deleteFeedPost(String timeuid) async {
    await _feedPostsRef.doc(timeuid).delete();
  }

  static Future<void> addCommentToFeedPost(
      String feedPostUid, Comment comment) async {
    await _feedPostsRef.doc(feedPostUid).update({
      "comments": FieldValue.arrayUnion([comment.toJson()])
    });
  }

  static Future<void> deleteCommentFromFeedPost(
      String feedPostUid, Comment comment) async {
    await _feedPostsRef.doc(feedPostUid).update({
      "comments": FieldValue.arrayRemove([comment.toJson()])
    });
  }

  static Future<void> addLikeToFeedPost(
      String feedPostUid, String userUid) async {
    await _feedPostsRef.doc(feedPostUid).update({
      "likes": FieldValue.arrayUnion([userUid])
    });
  }

  static Future<void> removeLikeFromFeedPost(
      String feedPostUid, String userUid) async {
    await _feedPostsRef.doc(feedPostUid).update({
      "likes": FieldValue.arrayRemove([userUid])
    });
  }
}
