import 'package:bitsapp/models/comment.dart';
import 'package:bitsapp/models/media_file.dart';
import 'package:bitsapp/services/firestore_service.dart';
import 'package:bitsapp/services/logger_service.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feed_post.g.dart';

final feedPostDataProvider =
    StateNotifierProvider<FeedPostDataNotifier, List<FeedPost>>(
        (ref) => FeedPostDataNotifier());

@JsonSerializable()
class FeedPost {
  /// The generated code assumes these values exist in JSON.
  final String posterUid;
  final String timeuid;
  final String text;
  final List<MediaFile> mediaFilesList;
  final List<Comment> comments;
  final List<String> likes;
  FeedPost(this.mediaFilesList, this.posterUid, this.likes,
      {required this.timeuid, required this.text, required this.comments});

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.
  factory FeedPost.fromJson(Map<String, dynamic> json) =>
      _$FeedPostFromJson(json);

  /// Connect the generated [_$FeedPostToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FeedPostToJson(this);
}

class FeedPostDataNotifier extends StateNotifier<List<FeedPost>> {
  //list of feedPosts constructor
  FeedPostDataNotifier() : super([]);

  void initfeedPostsData(List<FeedPost> FeedPost) {
    state = FeedPost;
  }

  //add feedPost to list
  Future<void> addFeedPost(FeedPost feedPost) async {
    try {
      await FirestoreService.addFeedPost(feedPost).then((value) {
        state = state..add(feedPost);
      });

      dlog('feedPost ${feedPost.timeuid} added to list');
    } catch (e) {
      elog(e.toString());
    }
  }

  //delete feedPost from list
  Future<void> deletefeedPost(String feedPostUid) async {
    try {
      await FirestoreService.deleteFeedPost(feedPostUid).then((value) {
        state =
            state.where((feedPost) => feedPost.timeuid != feedPostUid).toList();
      });
      dlog("$feedPostUid deleted from list");
    } catch (e) {
      elog(e.toString());
    }
  }
  Future<void> addComment(String feedPostUid, Comment comment) async {
    try {
      await FirestoreService.addCommentToFeedPost(feedPostUid, comment).then((value) {
        state = state
          ..where((feedPost) => feedPost.timeuid == feedPostUid)
              .first
              .comments
              .add(comment);
      });
      dlog("${comment.text} added to $feedPostUid");
    } catch (e) {
      elog(e.toString());
    }
  }

  Future<void> addLike(String feedPostUid, String uid) async {
    try {
      await FirestoreService.addLikeToFeedPost(feedPostUid, uid).then((value) {
        state = state
          ..where((feedPost) => feedPost.timeuid == feedPostUid)
              .first
              .likes
              .add(uid);
      });
      dlog("$uid added to likes of $feedPostUid");
    } catch (e) {
      elog(e.toString());
    }
  }

  Future<void> removeLike(String feedPostUid, String uid) async {
    try {
      await FirestoreService.removeLikeFromFeedPost(feedPostUid, uid).then((value) {
        state = state
          ..where((feedPost) => feedPost.timeuid == feedPostUid)
              .first
              .likes
              .remove(uid);
      });
      dlog("$uid removed from likes of $feedPostUid");
    } catch (e) {
      elog(e.toString());
    }
  }

}
