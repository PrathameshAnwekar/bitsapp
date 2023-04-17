import 'package:bitsapp/constants/size_config.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/views/Feed_Screen/components/image_container.dart';
import 'package:bitsapp/views/Feed_Screen/components/video_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatPostContainer extends ConsumerStatefulWidget {
  final Message message;

  const ChatPostContainer({required super.key, required this.message});
  @override
  ChatPostContainerState createState() {
    return ChatPostContainerState();
  }
}

class ChatPostContainerState extends ConsumerState<ChatPostContainer>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // This line is important
    final postUid = widget.message.text.substring(
        25,
        widget.message.text
            .length); // 25 is the length of the string "InternalPostShare@"
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("FeedPosts")
            .doc(postUid)
            .get(const GetOptions(source: Source.serverAndCache)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: SizeConfig.screenHeight * 0.4,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            final post = FeedPost.fromJson(snapshot.data!.data()!);
            final BitsUser postAuthor = ref
                .read(contactsListProvider)
                .firstWhere((element) => element.uid == post.posterUid);
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
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

  @override
  bool get wantKeepAlive => true;
}
