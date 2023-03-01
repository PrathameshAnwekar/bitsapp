import 'package:flutter/material.dart';

class Constants {
  static Map<String, dynamic> statusList = {
    "Accepted": Colors.green,
    "Pending": Colors.yellow.shade700,
    "Rejected": Colors.red,
  };

  static final bottomBarIcons = [
    "assets/Icons/home.svg",
    "assets/Icons/freelance.svg",
    "assets/Icons/addnewad.svg",
    "assets/Icons/message.svg",
    "assets/Icons/person.svg",
  ];

  static final postOptionIcons = [
    'assets/Icons/like.svg',
    'assets/Icons/comment.svg',
    'assets/Icons/bookmark.svg',
    'assets/Icons/share.svg',
  ];

  static const kPrimaryColor = Color(0xFF00BF6D);
  static const kSecondaryColor = Color(0xFFFE9901);
  static const kContentColorLightTheme = Color(0xFF1D1D35);
  static const kContentColorDarkTheme = Color(0xFFF5FCF9);
  static const kWarninngColor = Color(0xFFF3BB1C);
  static const kErrorColor = Color(0xFFF03738);
  static const kDefaultPadding = 20.0;
}
