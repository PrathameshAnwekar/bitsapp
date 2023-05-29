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
import 'package:bitsapp/services/firestore_feed_service.dart';
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

class FirestoreInternshipService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _chatRoomsRef = _firestore.collection("ChatRooms");
  static final _usersRef = _firestore.collection("Users");
  static final _internshipsRef = _firestore.collection("Internships");
  static final _feedPostsRef = _firestore.collection("FeedPosts");
  static final _firebaseStorage = FirebaseStorage.instance.ref();

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
}