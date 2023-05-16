import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Title1 extends StatelessWidget {
  final String txt;
  const Title1({
    super.key,
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        txt,
        style: GoogleFonts.roboto(
          color: Colors.black.withOpacity(0.7),
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
