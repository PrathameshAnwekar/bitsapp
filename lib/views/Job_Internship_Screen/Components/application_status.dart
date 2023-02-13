import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationStatus extends StatelessWidget {
  final String text;
  final Color color;
  const ApplicationStatus({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
        ),
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
