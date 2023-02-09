import 'package:bitsapp/models/message.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        
        color: kPrimaryColor.withOpacity(message.sender == "me" ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message.text,
        style: TextStyle(
          color: message.sender == "me"
              ? Colors.white
              : Theme.of(context).textTheme.bodyLarge!.color,
        ),
      ),
    );
  }
}