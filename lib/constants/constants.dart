import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Constants {
  static final Map<String, Color> statusList = {
    "Accepted": Colors.green,
    "Pending": Colors.yellow.shade700,
    "Rejected": Colors.red,
  };

  static final List<IconData> socialIcons = [
    FontAwesomeIcons.instagram,
    FontAwesomeIcons.linkedin,
    FontAwesomeIcons.github,
    FontAwesomeIcons.twitter,
  ];

  static final List<Color> socialIconColors = [
    const Color(0xffBE2289),
    const Color(0xff0085E0),
    const Color(0xff202020),
    const Color(0xff00ABEA),
  ];

  static final bottomBarIcons = [
    "assets/icons/home.svg",
    "assets/icons/freelance.svg",
    "assets/icons/addnewad.svg",
    "assets/icons/message.svg",
    "assets/icons/person.svg",
  ];

  static final postOptionIcons = [
    'assets/icons/like_outline.svg',
    'assets/icons/like_filled.svg',
    'assets/icons/comment.svg',
    'assets/icons/bookmark.svg',
    'assets/icons/share.svg',
  ];

  static final List<String> skills = [
    "Java",
    "Python",
    "JavaScript",
    "C++",
    "C#",
    "Ruby",
    "Swift",
    "Kotlin",
    "PHP",
    "Go",
    "Rust",
    "MATLAB",
    "R",
    "TypeScript",
    "Perl",
    "Shell scripting",
    "HTML/CSS",
    "Scala",
    "Julia",
    "Dart",
    "Flutter",
    "React Native",
    "Angular",
    ".NET",
    "Spring framework",
    "Django",
    "TensorFlow",
    "PyTorch",
    "Unity",
    "JavaScript",
    "React",
    "Vue.js",
    "Node.js",
    "Ruby on Rails",
    "SwiftUI",
    "MongoDB",
    "GraphQL",
    "Redux",
    "AWS",
    "Docker",
    "Kubernetes",
    "Git",
    "Jenkins"
  ];

  static const kPrimaryColor = Color(0xFF1979fa);
  static const kSecondaryColor = Color(0xFFf8f7fc);
  static const k2SecondaryColor = Color(0xFFf7f7f8);
  static const kContentColorLightTheme = Color(0xFF1D1D35);
  static const kContentColorDarkTheme = Color(0xFFF5FCF9);
  static const kWarninngColor = Color(0xFFF3BB1C);
  static const kErrorColor = Color(0xFFF03738);
  static const kDefaultPadding = 20.0;
  static const inactiveIconColor = Color.fromARGB(255, 150, 149, 170);
}
