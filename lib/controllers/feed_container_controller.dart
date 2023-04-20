import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/models/comment.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/services/firestore_service.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:bitsapp/storage/hiveStore.dart';
import 'package:bitsapp/views/feed_screen/components/share_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class FeedContainerController {
  static Future<void> toggleLike({
    required ValueNotifier<bool> likeStatus,
    required String localUserUid,
    required WidgetRef ref,
    required String feedPostUid,
  }) async {
    try{if (likeStatus.value) {
      await ref.read(feedPostDataProvider.notifier).removeLike(feedPostUid, localUserUid);
      likeStatus.value = false;
    } else {
      await ref.read(feedPostDataProvider.notifier).addLike(feedPostUid,localUserUid);
      likeStatus.value = true;
    }}catch(e){
      elog(e.toString());
    }
  }

  static Future<bool> addCommentToPost(
      {required FeedPost feedPost,
      required TextEditingController commentController,
      required WidgetRef ref}) async {
    try {
      if (commentController.text.trim() == "") return false;
      final comment = Comment(
          posterUid: feedPost.posterUid,
          text: commentController.text.trim(),
          timeUid: DateTime.now().millisecondsSinceEpoch);
      ref
          .read(feedPostDataProvider.notifier)
          .addComment(feedPost.timeuid, comment);
      commentController.clear();
      return Future.value(true);
    } catch (e) {
      elog(e.toString());
      return Future.value(false);
    }
  }

  static Future<bool> removeCommentFromPost(
      FeedPost feedpost, Comment comment) async {
    try {
      await FirestoreService.deleteCommentFromFeedPost(
          feedpost.timeuid, comment);
      feedpost.comments.remove(comment);
      return Future.value(true);
    } catch (e) {
      elog(e.toString());
      return Future.value(false);
    }
  }

  static Future<bool> deletePost(FeedPost feedpost) async {
    try {
      await FirestoreService.deleteFeedPost(feedpost.timeuid);
      return Future.value(true);
    } catch (e) {
      elog(e.toString());
      return Future.value(false);
    }
  }

  static Future<bool> bookmarkFeedPost(FeedPost feedpost) async {
    try {
      await HiveStore.bookmarkedPosts.add(feedpost.timeuid);
      return Future.value(true);
    } catch (e) {
      elog(e.toString());
      return Future.value(false);
    }
  }

  static Future<void> openShareSheet(context, FeedPost feedPost) async {
    return showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        builder: (context) => ShareSheet(
              feedPost: feedPost,
            ));
  }

  static Future<bool> shareFeedPostInternally(
      FeedPost feedpost, WidgetRef ref, List<String> uids) async {
    try {
      //CUSTOM STRING FOR POSTS TO BE INTERPRETED BY THE APP
      final String shareString = "ApplicationInternalShare@${feedpost.timeuid}";
      final chatRooms = ref.read(chatRoomsProvider);
      final localUser = ref.read(localUserProvider);
      final contacts = ref.read(contactsListProvider);
      List<ChatRoom> chatRoomToShare = [];

      for (int i = 0; i < uids.length; i++) {
        ChatRoom chatRoom = chatRooms.firstWhere(
            (element) => element.userUidList.contains(uids[i]), orElse: () {
          ///CREATING NEW CHATROOM IF IT DOESN'T EXIST ALREADY
          final otherUser =
              contacts.firstWhere((element) => element.uid == uids[i]);
          final chatRoomUid = localUser.uid.compareTo(uids[i]) < 0
              ? localUser.uid + otherUser.uid
              : otherUser.uid + localUser.uid;
          final newChatRoom = ChatRoom(
              uid: chatRoomUid,
              userUidList: [localUser.uid, otherUser.uid],
              messages: []);
          ref.read(localUserProvider.notifier).addChatRoom(chatRoomUid);
          ref
              .read(chatRoomsProvider.notifier)
              .addChatRoom(newChatRoom, localUser.uid, otherUser.uid);
          return newChatRoom;
        });
        chatRoomToShare.add(chatRoom);
      }
      for (int i = 0; i < chatRoomToShare.length; i++) {
        final otherUserUid = chatRoomToShare[i]
            .userUidList
            .firstWhere((element) => localUser.uid != element);
        final fcmToken = contacts
            .firstWhere((element) => element.uid == otherUserUid)
            .fcmToken;
        final message = Message(
            sender: localUser.uid,
            text: shareString,
            type: MessageType.feedpost,
            replyOf: null,
            time: DateTime.now().millisecondsSinceEpoch);
        ref.read(chatRoomsProvider.notifier).addMessage(
            chatRoomToShare[i].uid, message, fcmToken ?? "null", "Someone new");
      }
      return Future.value(true);
    } catch (e) {
      elog(e.toString());
      return Future.value(false);
    }
  }

  static Future<bool> shareFeedPostExternally(
      FeedPost feedpost, WidgetRef ref) async {
    try {
      final poster = ref
          .read(contactsListProvider)
          .firstWhere((element) => element.uid == feedpost.posterUid);
      final text =
          'Posted by ${poster.name}\nShared via BitsApp\n\n${feedpost.text}';
      final xfiles = await _xFileBuilder(feedpost);
      Share.shareXFiles(xfiles, text: text, subject: 'BitsApp');
      return Future.value(true);
    } catch (e) {
      elog(e.toString());
      return Future.value(false);
    }
  }

  static Future<List<XFile>> _xFileBuilder(FeedPost feedpost) async {
    List<File> fileList = [];
    for (var i = 0; i < feedpost.mediaFilesList.length; i++) {
      final file = await DefaultCacheManager()
          .getSingleFile(feedpost.mediaFilesList[i].url);
      fileList.add(file);
    }
    List<XFile> xfiles = [];
    for (int i = 0; i < fileList.length; i++) {
      xfiles.add(XFile(fileList[i].path,
          name: "BitsApp_${DateTime.now().millisecondsSinceEpoch}"));
    }
    dlog("Sharing $xfiles files");
    return Future.value(xfiles);
  }
}
