import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/services/firebase_chat_channel_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChannelChatInputField extends HookConsumerWidget {
  final String chatRoomName;
  final String receiverFcmToken;
  final FocusNode focusNode;
  final VoidCallback reset;

  const ChannelChatInputField({
    Key? key,
    required this.chatRoomName,
    required this.focusNode,
    required this.receiverFcmToken,
    required this.reset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    const inputBottomRadius = Radius.circular(24);
    return Container(
      color: Constants.kSecondaryColor,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 16, top: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                // if (isReplying)
                //   Container(
                //     padding: const EdgeInsets.all(8),
                //     decoration: const BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(12),
                //         topRight: Radius.circular(12),
                //       ),
                //     ),
                //     child: ReplyMessageWidget(
                //       receiverUsername: receiver.name,
                //       message: replyOfText,
                //       onCancelReply: reset,
                //     ),
                //   ),
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
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.only(
                        topLeft: inputBottomRadius,
                        topRight: inputBottomRadius,
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
