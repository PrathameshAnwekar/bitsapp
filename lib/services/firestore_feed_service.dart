import 'dart:io';

import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/comment.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/models/media_file.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:bitsapp/services/notif_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FirestoreFeedService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _chatRoomsRef = _firestore.collection("ChatRooms");
  static final _usersRef = _firestore.collection("Users");
  static final _internshipsRef = _firestore.collection("Internships");
  static final _feedPostsRef = _firestore.collection("FeedPosts");
  static final _firebaseStorage = FirebaseStorage.instance.ref();
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

  static Future<void> setUserDescription(
      String desc, String uid, WidgetRef ref) async {
    try {
      await _usersRef.doc(uid).update({"profileDescription": desc});
      ref.read(localUserProvider.notifier).setUserDescription(desc);
    } catch (e) {
      elog(e.toString());
    }
  }

  static Future<void> addFeedPost(
      FeedPost feedPost, Map<File, String> files, WidgetRef ref) async {
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
      await _usersRef.doc(feedPost.posterUid).update({
        "feedPosts": FieldValue.arrayUnion([feedPost.timeuid])
      });
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
