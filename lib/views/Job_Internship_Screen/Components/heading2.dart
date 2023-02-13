import 'package:flutter/material.dart';

class Heading2 extends StatelessWidget {
  final String txt1;
  final String txt2;
  const Heading2({
    super.key,
    required this.txt1,
    required this.txt2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            txt1,
            style: const TextStyle(
              color: Color(0xFF4D5470),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          Text(
            txt2,
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
