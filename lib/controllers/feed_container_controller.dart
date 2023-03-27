import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/models/comment.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/services/firestore_service.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:bitsapp/storage/hiveStore.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class FeedContainerController {
  static Future<bool> addLikeToPost(
      FeedPost feedpost, String localUserUid) async {
    try {
      await FirestoreService.addLikeToFeedPost(feedpost.timeuid, localUserUid);
      feedpost.likes.add(localUserUid);
      return Future.value(true);
    } catch (e) {
      elog(e.toString());
      return Future.value(false);
    }
  }

  static Future<bool> addCommentToPost(
      FeedPost feedpost, Comment comment) async {
    try {
      await FirestoreService.addCommentToFeedPost(feedpost.timeuid, comment);
      feedpost.comments.add(comment);
      return Future.value(true);
    } catch (e) {
      elog(e.toString());
      return Future.value(false);
    }
  }

  static Future<bool> removeLikeFromPost(
      FeedPost feedpost, String localUserUid) async {
    try {
      await FirestoreService.removeLikeFromFeedPost(
          feedpost.timeuid, localUserUid);
      feedpost.likes.remove(localUserUid);
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

  static Future<bool> shareFeedPostInternally(
      FeedPost feedpost, WidgetRef ref, List<String> uids) async {
    try {
      final String shareString = "InternalShare@${feedpost.timeuid}";
      final chatRooms = ref.read(chatRoomsProvider);
      final localUser = ref.read(localUserProvider);
      List chatRoomToShare = [];

      //TODO: Add support for new chat rooms
      //TODO: Add FcmId to Message
      for (int i = 0; i < uids.length; i++) {
        ChatRoom chatRoom = chatRooms.firstWhere(
            (element) => element.userUidList.contains(uids[i]),
            orElse: () => ChatRoom(uid: "null", userUidList: [], messages: []));
        if (chatRoom.uid != "null") chatRoomToShare.add(chatRoom);
      }
      for (int i = 0; i < chatRoomToShare.length; i++) {
        final message = Message(
            sender: localUser.uid,
            text: shareString,
            time: DateTime.now().millisecondsSinceEpoch);
        ref
            .read(chatRoomsProvider.notifier)
            .addMessage(chatRoomToShare[i].uid, message, "null");
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
    dlog("Sharing ${xfiles} files");
    return Future.value(xfiles);
  }
}
