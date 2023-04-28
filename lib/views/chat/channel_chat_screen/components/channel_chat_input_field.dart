import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/services/firebase_chat_channel_service.dart';
import 'package:bitsapp/storage/hiveStore.dart';
import 'package:bitsapp/views/chat/chat_room_screen.dart';
import 'package:bitsapp/views/chat/components/reply_message.dart';
import 'package:bitsapp/views/chat/components/send_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/message_input_field.dart';

class ChannelChatInputField extends HookConsumerWidget {
  final String chatRoomName;
  final String senderName;
  final FocusNode focusNode;

  final VoidCallback reset;
  const ChannelChatInputField({
    Key? key,
    required this.chatRoomName,
    required this.senderName,
    required this.reset,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final Message? replyOfMessage = ref.watch(replyOfMessageProvider);
    final isReplying = replyOfMessage != null;
    final receiver = isReplying
        ? HiveStore.getUserFromStorage(uid: replyOfMessage.sender) ??
            BitsUser.dummy
        : null;
    final recieverName = isReplying ? receiver!.name : "";
    return Container(
      color: Constants.kSecondaryColor,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 16, top: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
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
                MessageInputField(
                  focusNode: focusNode,
                  textController: textController,
                  isReplying: isReplying,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
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
                  ),
                );
                focusNode.unfocus();
                textController.clear();
              } else {
                textController.clear();
              }
              reset();
            },
            child: const SendButton(),
          ),
        ],
      ),
    );
  }
}
