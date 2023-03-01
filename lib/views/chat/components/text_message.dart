import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/message.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/constants.dart';

class TextMessage extends ConsumerWidget {
  const TextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localUser = ref.watch(localUserProvider);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.kDefaultPadding * 0.75,
        vertical: Constants.kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Constants.kPrimaryColor
            .withOpacity(message.sender == localUser.uid ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message.text,
        style: TextStyle(
          color: message.sender == localUser.uid
              ? Colors.white
              : Theme.of(context).textTheme.bodyLarge!.color,
        ),
      ),
    );
  }
}
