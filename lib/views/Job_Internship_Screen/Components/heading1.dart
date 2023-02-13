import 'package:flutter/material.dart';

class Heading1 extends StatelessWidget {
  final String txt;
  final double top;
  final double bottom;
  const Heading1({
    super.key,
    required this.txt,
    required this.top,
    required this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        bottom: bottom,
      ),
      child: Text(
        txt,
        style: const TextStyle(
          color: Color(0xFF4D5470),
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
    );
  }
}
