import 'package:bitsapp/constants/constants.dart';
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
        color: Constants.inactiveIconColor.withOpacity(0.8),
        // border: Border.all(color: Constants.inactiveIconColor.withOpacity(0.8)),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          color: Colors.white,
          // color: Colors.black.withOpacity(0.8),
          fontSize: textSize,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
