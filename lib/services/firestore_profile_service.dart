import 'dart:io';

import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/user_experience.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:bitsapp/storage/hiveStore.dart';
import 'package:bitsapp/views/auth/auth_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FirestoreProfileService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _chatRoomsRef = _firestore.collection("ChatRooms");
  static final _usersRef = _firestore.collection("Users");
  static final _internshipsRef = _firestore.collection("Internships");
  static final _feedPostsRef = _firestore.collection("FeedPosts");
  static final _firebaseStorage = FirebaseStorage.instance.ref();
  static Future<void> initUser(WidgetRef ref, BuildContext context) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      final userDoc = await _usersRef
          .doc(uid)
          .get(const GetOptions(source: Source.serverAndCache));
      final user = BitsUser.fromJson(userDoc.data()!);

      ref.read(localUserProvider.notifier).setUser(user);
    } catch (e) {
      elog(e.toString());
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text("You've been logged out, please log in again.")));
      if (context.mounted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AuthScreen.routeName, (route) => false);
      }
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

  static Future<void> addUserExperience(String uid, UserExperience exp) async {
    try {
      await _usersRef.doc(uid).set({
        "userExperience": FieldValue.arrayUnion([exp.toJson()])
      }, SetOptions(merge: true));
    } catch (e) {
      elog(e.toString());
    }
  }

  static Future<void> removeUserExperience(
      String uid, UserExperience experience) async {
    try {
      await _usersRef.doc(uid).set({
        "userExperience": FieldValue.arrayRemove([experience.toJson()])
      }, SetOptions(merge: true));
    } catch (e) {
      elog(e.toString());
    }
  }

  static Future<void> uploadResume(
      File pdf, String userUid, BuildContext context, WidgetRef ref) async {
    try {
      final url = await _firebaseStorage
          .child("resumes/$userUid")
          .putFile(pdf)
          .then((value) => value.ref.getDownloadURL());
      await _usersRef
          .doc(userUid)
          .set({"resumeLink": url}, SetOptions(merge: true));
      await initUser(ref, context);
    } catch (e) {
      elog(e.toString());
    }
  }

  static Future<void> setChatBarrier(bool value, String userUid) async {
    try {
      _usersRef
          .doc(userUid)
          .set({"chatBarrier": value}, SetOptions(merge: true));
    } catch (e) {
      elog(e.toString());
    }
  }

  static Future<String> uploadProfilePicture(
      File image, String userUid, WidgetRef ref) async {
    try {
      final url = await _firebaseStorage
          .child("profilePictures/$userUid")
          .putFile(image)
          .then((value) => value.ref.getDownloadURL());
      await _usersRef
          .doc(userUid)
          .set({"profilePicUrl": url}, SetOptions(merge: true));
      
      return url;
    } catch (e) {
      elog(e.toString());
      return "";
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

      await HiveStore.storeAllUsersToStorage(allUsersList);
      allUsersList.removeWhere((e) => e.uid == ref.read(localUserProvider).uid);
      ref.read(contactsListProvider.notifier).state = allUsersList;

      dlog("initialised ${allUsersList.length} contacts");
    } catch (e) {
      elog(e.toString());
    }
  }
}
