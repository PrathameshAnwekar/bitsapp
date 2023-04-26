import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/services/firebase_chat_channel_service.dart';
import 'package:bitsapp/storage/hiveStore.dart';
import 'package:bitsapp/views/chat/chat_room_screen.dart';
import 'package:bitsapp/views/chat/components/reply_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChannelChatInputField extends HookConsumerWidget {
  final String chatRoomName;
    final String senderName;


  final VoidCallback reset;
  const ChannelChatInputField(
      {Key? key,
      required this.chatRoomName,
      required this.senderName, 
    
      required this.reset})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final Message? replyOfMessage = ref.watch(replyOfMessageProvider);
 
    final isReplying = replyOfMessage != null;
    final receiver = isReplying ? HiveStore.getUserFromStorage(uid: replyOfMessage.sender) ?? BitsUser.dummy : null;
    final recieverName = isReplying ? receiver!.name : "";
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.kDefaultPadding,
        vertical: Constants.kDefaultPadding / 2,
      ),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                if (isReplying)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: ReplyMessageWidget(
                      receiverUsername: recieverName,
                      message: replyOfMessage.text,
                      onCancelReply: reset,
                    ),
                  ),
                const SizedBox(width: Constants.kDefaultPadding / 2),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.kDefaultPadding * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: Constants.kPrimaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sentiment_satisfied_alt_outlined,
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.64),
                        ),
                        const SizedBox(width: Constants.kDefaultPadding / 4),
                        Expanded(
                          child: TextField(
                            controller: textController,
                            decoration: const InputDecoration(
                              hintText: "Type message",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.attach_file,
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.64),
                        ),
                        const SizedBox(width: Constants.kDefaultPadding / 4),
                        GestureDetector(
                          onTap: () {
                            if (textController.text.trim() != "") {
                              FirestoreChannelService.addMessageToChannel(
                                  chatRoomName,
                                  Message(
                                    text: textController.text,
                                    time: DateTime.now().millisecondsSinceEpoch,
                                    sender: ref.read(localUserProvider).uid,
                                    type: MessageType.text,
                                    replyOf: null,
                                  ));
                            } else {
                              textController.clear();
                            }
                            reset();
                          },
                          child: Icon(
                            Icons.send,
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(0.64),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
