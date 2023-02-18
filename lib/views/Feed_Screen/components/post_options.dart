import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PostOptionButtons extends StatelessWidget {
  const PostOptionButtons({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: SvgPicture.asset(
        icon,
        width: 26,
        height: 26,
        color: Colors.black,
      ),
    );
  }
}
