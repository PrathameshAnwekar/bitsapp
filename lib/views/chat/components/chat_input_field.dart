import 'package:bitsapp/controllers/chat_controller.dart';
import 'package:bitsapp/views/chat/chat_room_screen.dart';
import 'package:bitsapp/views/chat/components/reply_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/bits_user.dart';

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
    final String? replyOf = ref.watch(replyOfProvider);
    final String? replyOfText = ref.watch(replyOfTextProvider);
    final isReplying = replyOfText != null;
    const inputBottomRadius = Radius.circular(24);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                if (isReplying)
                  Container(
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
                      message: replyOfText,
                      onCancelReply: reset,
                    ),
                  ),
                TextField(
                  focusNode: focusNode,
                  cursorColor: Colors.black,
                  controller: textController,
                  cursorRadius: const Radius.circular(5),
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  enableSuggestions: true,
                  style: GoogleFonts.roboto(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: 'Type a message',
                    hintStyle: GoogleFonts.roboto(color: Colors.black54),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.only(
                        topLeft: isReplying ? Radius.zero : inputBottomRadius,
                        topRight: isReplying ? Radius.zero : inputBottomRadius,
                        bottomLeft: inputBottomRadius,
                        bottomRight: inputBottomRadius,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              if (textController.text.trim() != "") {
                ChatController.sendMessage(
                  ref: ref,
                  textController: textController,
                  chatRoomUid: chatRoomUid,
                  receiverFcmToken: receiver.fcmToken!,
                  senderName: senderName,
                  replyOf: replyOf,
                );
                FocusScope.of(context).unfocus();
              } else {
                textController.clear();
              }
              reset();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
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
