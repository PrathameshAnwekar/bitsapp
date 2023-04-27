import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class TextBox extends StatelessWidget {
  final Widget child;
  final bool isSender;
  const TextBox({super.key, required this.child, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: Constants.kDefaultPadding / 2 + 3,
      ),
      constraints: const BoxConstraints(maxWidth: 300),
      decoration: BoxDecoration(
        color: isSender ? Constants.kPrimaryColor : Colors.white,
        gradient: isSender
            ? LinearGradient(
                colors: [
                  Constants.kPrimaryColor.withOpacity(0.76),
                  Constants.kPrimaryColor
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10),
          bottomLeft: Radius.circular(isSender ? 10 : 0),
          bottomRight: Radius.circular(isSender ? 0 : 10),
        ),
      ),
      child: child,
    );
  }
}
