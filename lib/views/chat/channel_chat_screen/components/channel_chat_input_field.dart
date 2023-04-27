import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/services/firebase_chat_channel_service.dart';
import 'package:bitsapp/storage/hiveStore.dart';
import 'package:bitsapp/views/chat/chat_room_screen.dart';
import 'package:bitsapp/views/chat/components/reply_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    const inputBottomRadius = Radius.circular(24);
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
                    fillColor: Colors.white,
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
            child: Container(
              padding: const EdgeInsets.fromLTRB(14, 15, 12, 15),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Constants.kPrimaryColor,
              ),
              child: SvgPicture.asset(
                "assets/icons/share_filled.svg",
                width: 28,
                height: 28,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
