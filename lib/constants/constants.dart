import 'package:flutter/material.dart';

class Constants {
  static Map<String, dynamic> statusList = {
    "Accepted": Colors.green,
    "Pending": Colors.yellow.shade700,
    "Rejected": Colors.red,
  };

  static final bottomBarIcons = [
    "assets/icons/home.svg",
    "assets/icons/freelance.svg",
    "assets/icons/addnewad.svg",
    "assets/icons/message.svg",
    "assets/icons/person.svg",
  ];

  static final postOptionIcons = [
    'assets/icons/like.svg',
    'assets/icons/comment.svg',
    'assets/icons/bookmark.svg',
    'assets/icons/share.svg',
  ];

  static const kPrimaryColor = Color(0xFF00BF6D);
  static const kSecondaryColor = Color(0xFFFE9901);
  static const kContentColorLightTheme = Color(0xFF1D1D35);
  static const kContentColorDarkTheme = Color(0xFFF5FCF9);
  static const kWarninngColor = Color(0xFFF3BB1C);
  static const kErrorColor = Color(0xFFF03738);
  static const kDefaultPadding = 20.0;
}
