import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/models/message.dart';
import 'package:bitsapp/views/chat/chat.dart';
import 'package:bitsapp/views/chat/components/chat_bubble.dart';
import 'package:bitsapp/views/chat/components/chat_post_container.dart';
import 'package:bitsapp/views/feed_screen/components/media_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'chat_input_field.dart';
import 'text_message.dart';

// class Body extends HookConsumerWidget {
//   final String chatRoomUid;
//   final BitsUser receiver;
//   const Body({super.key, required this.chatRoomUid, required this.receiver});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final replyOfHook = useState<String?>(null);
//     final replyOfText = useState<String?>(null);
//     final localUser = ref.read(localUserProvider);
//     final chatStream = ref.watch(chatStreamProvider(chatRoomUid));
//     final messages = ref
//         .watch(chatRoomsProvider)
//         .firstWhere((element) => element.uid == chatRoomUid)
//         .messages;
//     return Column(
//       children: [
//         Expanded(
//           child: chatStream.when(
//               data: (snapshot) {
//                 return ListView.builder(
//                     reverse: true,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: Constants.kDefaultPadding),
//                     physics: const ClampingScrollPhysics(),
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message = messages[messages.length - index - 1];
//                       final key = ValueKey(message.time);
//                       String? replyText;
//                       if (message.replyOf != null) {
//                         final replyOfMessage = messages.firstWhere((element) =>
//                             element.time.toString() == message.replyOf);
//                         replyText = replyOfMessage.text;
//                       }
//                       if (message.type == MessageType.text) {
//                         return ChatBubble(
//                             key: key,
//                             message: message,
//                             replyText: replyText,
//                             messages: messages,
//                             replyOfHook: replyOfHook,
//                             index: index,
//                             replyOfText: replyOfText,
//                             selectMessageForReply: selectMessageForReply);
                      
//                       } else if (message.type == MessageType.feedpost) {
//                         return ChatPostContainer(key: key ,message: message);
//                       }
//                     });
//               },
//               error: (e, stackTrace) =>
//                   Text("Please check you Internet Connection $e"),
//               loading: () => const CircularProgressIndicator()),
//         ),
//         ChatInputField(
//           chatRoomUid: chatRoomUid,
//           receiverFcmToken: receiver.fcmToken.toString(),
//           senderName: localUser.name.toString(),
//           replyOf: replyOfHook.value,
//           replyOfText: replyOfText.value,
//           reset: () {
//             replyOfHook.value = null;
//             replyOfText.value = null;
//           },
//         ),
//       ],
//     );
//   }


//   void selectMessageForReply(ValueNotifier<String?> replyOfHook,
//       Message message, int index, ValueNotifier<String?> replyOfText) {
//     if (replyOfHook.value == null) {
//       replyOfHook.value = message.time.toString();
//       replyOfText.value = message.text;
//     } else {
//       replyOfHook.value = null;
//       replyOfText.value = null;
//     }
//   }
// }


class Body extends StatefulHookConsumerWidget {
  const Body( {super.key, required this.chatRoomUid,required this.receiver,});
 final String chatRoomUid;
  final BitsUser receiver;

  @override
  BodyState createState() {
    return BodyState();
  }
}

class BodyState extends ConsumerState<Body>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final replyOfHook = useState<String?>(null);
    final replyOfText = useState<String?>(null);
    final localUser = ref.read(localUserProvider);
    final chatStream = ref.watch(chatStreamProvider( widget.chatRoomUid));
    final messages = ref
        .watch(chatRoomsProvider)
        .firstWhere((element) => element.uid ==  widget.chatRoomUid)
        .messages;
    return Column(
      children: [
        Expanded(
          child: chatStream.when(
              data: (snapshot) {
                return ListView.builder(
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
                            replyOfHook: replyOfHook,
                            index: index,
                            replyOfText: replyOfText,
                            selectMessageForReply: selectMessageForReply);
                      
                      } else if (message.type == MessageType.feedpost) {
                        return ChatPostContainer(key: key ,message: message);
                      }
                    });
              },
              error: (e, stackTrace) =>
                  Text("Please check you Internet Connection $e"),
              loading: () => const CircularProgressIndicator()),
        ),
        ChatInputField(
          chatRoomUid: widget.chatRoomUid,
          receiverFcmToken:  widget.receiver.fcmToken.toString(),
          senderName: localUser.name.toString(),
          replyOf: replyOfHook.value,
          replyOfText: replyOfText.value,
          reset: () {
            replyOfHook.value = null;
            replyOfText.value = null;
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
  void selectMessageForReply(ValueNotifier<String?> replyOfHook,
      Message message, int index, ValueNotifier<String?> replyOfText) {
    if (replyOfHook.value == null) {
      replyOfHook.value = message.time.toString();
      replyOfText.value = message.text;
    } else {
      replyOfHook.value = null;
      replyOfText.value = null;
    }
  }
}
