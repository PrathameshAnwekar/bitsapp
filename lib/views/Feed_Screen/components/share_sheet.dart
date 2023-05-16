import 'package:bitsapp/constants/size_config.dart';
import 'package:bitsapp/controllers/feed_container_controller.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/feed_post.dart';
import 'package:bitsapp/views/feed_screen/components/send_message_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShareSheet extends HookConsumerWidget {
  const ShareSheet({super.key, required this.feedPost});
  final FeedPost feedPost;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsList = ref.watch(contactsListProvider);
    final shareList = useState(<String>[]);
    
    return Wrap(children: <Widget>[
      SizedBox(
        height: SizeConfig.screenHeight * 0.7,
        child: Container(
          height: SizeConfig.screenHeight * 0.6,
          decoration: const BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0))),
          child: ListView.builder(
              itemCount: contactsList.length,
              itemBuilder: (context, index) {
                return SendMessageCard(
                  user: contactsList[index],
                  shareList: shareList,
                );
              }),
        ),
      ),
      Container(
        height: SizeConfig.screenHeight * 0.075,
        color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () async {
                  await FeedContainerController.shareFeedPostExternally(
                          feedPost, ref)
                      .then((value) => Navigator.of(context).pop());
                },
                icon: const Icon(
                  Icons.share,
                  size: 30,
                )),
            IconButton(
                onPressed: () async {
                  await FeedContainerController.shareFeedPostInternally(
                          feedPost, ref, shareList.value)
                      .then((value) => Navigator.of(context).pop());
                },
                icon: const Icon(
                  Icons.send,
                  size: 30,
                ))
          ],
        ),
      ),
    ]);
  }
}
