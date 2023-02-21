import 'package:flutter/material.dart';

class Constants {
  static  Map<String, dynamic>  statusList = {
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
}
