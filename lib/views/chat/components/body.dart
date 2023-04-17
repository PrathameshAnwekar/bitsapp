import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/views/chat/chat_room_screen.dart';
import 'package:bitsapp/views/chat/components/chat_bubble.dart';
import 'package:bitsapp/views/chat/components/chat_post_container.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'chat_input_field.dart';

class Body extends StatefulHookConsumerWidget {
  const Body({
    super.key,
    required this.chatRoomUid,
    required this.receiver,
  });
  final String chatRoomUid;
  final BitsUser receiver;

  @override
  BodyState createState() {
    return BodyState();
  }
}

class BodyState extends ConsumerState<Body> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final localUser = ref.read(localUserProvider);
   
    final messages = ref
        .watch(chatRoomsProvider)
        .firstWhere((element) => element.uid == widget.chatRoomUid)
        .messages;
    //edit all
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.kDefaultPadding),
                physics: const ClampingScrollPhysics(),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[messages.length - index - 1];
                  final key = ValueKey(message.time);
                  String? replyText;
                  if (message.replyOf != null) {
                    final replyOfMessage = messages.firstWhere((element) =>
                        element.time.toString() == message.replyOf);
                    replyText = replyOfMessage.text;
                  }
                  if (message.type == MessageType.text) {
                    return ChatBubble(
                        key: key,
                        message: message,
                        replyText: replyText,
                        messages: messages,
                        index: index,
                        ref: ref,
                        selectMessageForReply: selectMessageForReply);
                  } else if (message.type == MessageType.feedpost) {
                    return ChatPostContainer(key: key, message: message);
                  }
                  return SizedBox();
                })),
        ChatInputField(
          chatRoomUid: widget.chatRoomUid,
          receiverFcmToken: widget.receiver.fcmToken!,
          senderName: localUser.name,
          reset: () {
            ref.read(replyOfProvider.notifier).state = null;
            ref.read(replyOfTextProvider.notifier).state = null;
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
  void selectMessageForReply(WidgetRef ref, Message message, int index, ) {
    if (ref.read(replyOfProvider) == null) {
      ref.read(replyOfProvider.notifier).state = message.time.toString();
      ref.read(replyOfTextProvider.notifier).state = message.text;
    } else {
      ref.read(replyOfProvider.notifier).state = null;
      ref.read(replyOfTextProvider.notifier).state = null;
    }
  }
}
