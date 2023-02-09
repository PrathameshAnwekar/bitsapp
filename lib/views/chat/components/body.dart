import 'package:bitsapp/constants.dart';
import 'package:bitsapp/models/message.dart';
import 'package:flutter/material.dart';

import 'chat_input_field.dart';
import 'text_message.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              itemCount: Message.demoMessages.length,
              itemBuilder: (context, index) =>
                  TextMessage(message: Message.demoMessages[index]),
            ),
          ),
        ),
        ChatInputField(),
      ],
    );
  }
}