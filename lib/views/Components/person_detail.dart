import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonDetail extends StatelessWidget {
  const PersonDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Kaushal Kirpekar',
          style: GoogleFonts.dmSans(
            color: const Color(0xFF383D51),
            fontSize: 16,
          ),
        ),
        Text(
          '1d ago',
          style: GoogleFonts.dmSans(
            color: const Color(0xFF383D51),
            letterSpacing: 0.2,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
