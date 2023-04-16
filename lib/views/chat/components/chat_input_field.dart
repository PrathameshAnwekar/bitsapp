import 'package:auto_size_text/auto_size_text.dart';
import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatInputField extends HookConsumerWidget {
  final String chatRoomUid;
  final String receiverFcmToken;
  final String senderName;
  final String? replyOf;
  final String? replyOfText;
  final VoidCallback reset;
  const ChatInputField(
      {Key? key,
      required this.chatRoomUid,
      required this.receiverFcmToken,
      required this.senderName,
      required this.replyOf,
      required this.replyOfText,
      required this.reset})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.kDefaultPadding,
        vertical: Constants.kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            if (replyOf != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: replyOfText != null
                    ? AutoSizeText(
                        replyOfText!,
                        minFontSize: 15,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    : const Text(""),
              ),
            Row(
              children: [
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
                              ChatController.sendMessage(
                                  ref: ref,
                                  textController: textController,
                                  chatRoomUid: chatRoomUid,
                                  receiverFcmToken: receiverFcmToken,
                                  senderName: senderName,
                                  replyOf: replyOf);
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
