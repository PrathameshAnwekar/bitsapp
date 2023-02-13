import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tags extends StatelessWidget {
  final String text;
  final double inPadding;
  final double borderRadius;
  final double textSize;
  const Tags({
    super.key,
    required this.text,
    required this.inPadding,
    required this.borderRadius,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(inPadding),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withOpacity(0.7),
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          color: Colors.black.withOpacity(0.7),
          fontSize: textSize,
        ),
      ),
    );
  }
}
