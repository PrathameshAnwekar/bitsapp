import 'package:bitsapp/constants.dart';
import 'package:bitsapp/models/message.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        mainAxisAlignment:
            message.sender == "me" ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (! (message.sender == "me")) ...[
            CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage("assets/images/user_2.png"),
            ),
            SizedBox(width: kDefaultPadding / 2),
          ],
          messageContent(message),
          if (message.sender == "me") MessageStatusDot()
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
      return kPrimaryColor;
    }

    return Container(
      margin: EdgeInsets.only(left: kDefaultPadding / 2),
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
