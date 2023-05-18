import 'dart:io';

import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/models/comment.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/models/internship_application.dart';
import 'package:bitsapp/models/internship_data.dart';
import 'package:bitsapp/models/media_file.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/models/user_experience.dart';
import 'package:bitsapp/services/firestore_chat_service.dart';
import 'package:bitsapp/services/firestore_feed_service.dart';
import 'package:bitsapp/services/firestore_internship_serviced.dart';
import 'package:bitsapp/services/firestore_profile_service.dart';
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
      await FirestoreProfileService.initUser(ref, context);
      dlog("User initialised");
      await FirestoreProfileService.updateContactsList(ref).then((value) async {
        dlog("Contacts list updated");
        await FirestoreInternshipService.initInternshipData(ref);
        dlog("Internship data initialised");
        await FirestoreChatService.initialiseChatRooms(ref);
        dlog("Chat rooms initialised");
        await FirestoreFeedService.initFeedPosts(ref);
      });
      return true;
    } catch (e) {
      elog(e.toString());
      return false;
    }
  }

  static updateFcmToken(String token) async {
    await _usersRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"fcmToken": token});
  }


  
}
