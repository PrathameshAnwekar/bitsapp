import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/views/chat/chat_room_screen.dart';
import 'package:bitsapp/views/chat/components/chat_bubble.dart';
import 'package:bitsapp/views/chat/components/chat_post_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

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
          child: ListView.separated(
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
                final replyOfMessage = messages.firstWhere(
                    (element) => element.time.toString() == message.replyOf);
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
              return const SizedBox();
            },
            separatorBuilder: (context, index) {
              bool dateTag = false;
              bool lastMessages = false;
              DateTime msg1dur = DateTime.fromMillisecondsSinceEpoch(
                  messages[messages.length - index - 1].time);
              DateTime msg2dur;
              if (index < messages.length - 1) {
                msg2dur = DateTime.fromMillisecondsSinceEpoch(
                    messages[messages.length - index - 2].time);
              } else {
                lastMessages = true;
                msg2dur = DateTime.now();
              }
              if (msg1dur.day != msg2dur.day) dateTag = true;
              if (!dateTag) {
                return const SizedBox(height: 15);
              } else {
                String temp;
                int diff =
                    (DateTime.now().difference(msg1dur).inHours / 24).round();
                if (diff > 2) {
                  temp = DateFormat.yMMMMd().format(msg1dur);
                } else if (diff > 1) {
                  temp = "Yesterday";
                } else {
                  temp = "Today";
                }
                return SizedBox(
                  height: 55,
                  child: Center(
                    child: Text(
                      temp,
                      style: GoogleFonts.roboto(
                        fontSize: 12.5,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
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
  void selectMessageForReply(
    WidgetRef ref,
    Message message,
    int index,
  ) {
    if (ref.read(replyOfProvider) == null) {
      ref.read(replyOfProvider.notifier).state = message.time.toString();
      ref.read(replyOfTextProvider.notifier).state = message.text;
    } else {
      ref.read(replyOfProvider.notifier).state = null;
      ref.read(replyOfTextProvider.notifier).state = null;
    }
  }
}
