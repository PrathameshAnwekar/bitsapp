import 'package:bitsapp/constants/size_config.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:bitsapp/views/Feed_Screen/components/image_container.dart';
import 'package:bitsapp/views/Feed_Screen/components/video_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatPostContainer extends ConsumerWidget {
  const ChatPostContainer({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postUid = message.text.substring(25, message.text.length);
    print(postUid);
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("FeedPosts")
            .doc(postUid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            final post = FeedPost.fromJson(snapshot.data!.data()!);
            final BitsUser postAuthor = ref
                .read(contactsListProvider)
                .firstWhere((element) => element.uid == post.posterUid);
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              height: SizeConfig.screenHeight * 0.4,
              width: SizeConfig.screenWidth * 0.4,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    cacheExtent: 1000,
                    scrollDirection: Axis.horizontal,
                    itemCount: post.mediaFilesList.length,
                    itemBuilder: (context, index) {
                      final mediaFile = post.mediaFilesList[index];
                      if (mediaFile.type == 'image') {
                        return SizedBox(
                          width: SizeConfig.screenWidth * 1,
                          child: ImageContainer(
                            url: mediaFile.url,
                          ),
                        );
                      } else {
                        return SizedBox(
                            width: SizeConfig.screenWidth * 1,
                            child: VideoContainer(url: mediaFile.url));
                      }
                    },
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                      decoration: const BoxDecoration(
                          backgroundBlendMode: BlendMode.color,
                          color: Colors.white),
                      child: Text("${post.text} by ${postAuthor.name}",
                          style: const TextStyle(color: Colors.green))),
                ],
              ),
            );
          } else {
            return Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: const Text(
                "Post Not Available",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        });
  }
}
