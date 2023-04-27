import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/controllers/chat_controller.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/views/chat/chat_room_screen.dart';
import 'package:bitsapp/views/chat/components/reply_message.dart';
import 'package:bitsapp/views/chat/components/send_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/bits_user.dart';
import 'message_input_field.dart';

class ChatInputField extends HookConsumerWidget {
  final String chatRoomUid;
  final BitsUser receiver;
  final String senderName;
  final VoidCallback reset;
  final FocusNode focusNode;

  const ChatInputField({
    required this.chatRoomUid,
    required this.receiver,
    required this.senderName,
    required this.reset,
    required this.focusNode,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final Message? replyOfMessage = ref.watch(replyOfMessageProvider);
    final isReplying = replyOfMessage != null;
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
                      receiverUsername: receiver.name,
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
                ChatController.sendMessage(
                  ref: ref,
                  textController: textController,
                  chatRoomUid: chatRoomUid,
                  receiverFcmToken: receiver.fcmToken!,
                  senderName: senderName,
                  replyOf: replyOfMessage == null
                      ? null
                      : replyOfMessage.time.toString(),
                );
                focusNode.unfocus();
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

  Widget buildReply(String replyMessage) => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: ReplyMessageWidget(
          receiverUsername: receiver.name,
          message: replyMessage,
          onCancelReply: reset,
        ),
      );
}
