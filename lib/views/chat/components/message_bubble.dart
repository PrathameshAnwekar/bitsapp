import 'package:bitsapp/models/message.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import 'text_message.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    Widget messageContent(Message message) {
      return TextMessage(message: message);
    }

    return Padding(
      padding: const EdgeInsets.only(top: Constants.kDefaultPadding),
      child: Row(
        mainAxisAlignment: message.sender == "me"
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!(message.sender == "me")) ...[
            const CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage("assets/images/user_2.png"),
            ),
            const SizedBox(width: Constants.kDefaultPadding / 2),
          ],
          messageContent(message),
          if (message.sender == "me") const MessageStatusDot()
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  const MessageStatusDot({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color dotColor() {
      return Constants.kPrimaryColor;
    }

    return Container(
      margin: const EdgeInsets.only(left: Constants.kDefaultPadding / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(),
        shape: BoxShape.circle,
      ),
      child: Icon(
        true ? Icons.close : Icons.done,
        size: 8,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
