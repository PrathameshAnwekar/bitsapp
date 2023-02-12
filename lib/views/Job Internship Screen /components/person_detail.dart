import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonDetail extends StatelessWidget {
  const PersonDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 15,
          backgroundColor: const Color.fromRGBO(226, 210, 254, 1),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SvgPicture.asset(
              'assets/Icons/person.svg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Kaushal Kirpekar',
              style: GoogleFonts.dmSans(
                // color: Colors.white.withOpacity(0.9),
                color: const Color(0xFF383D51),
                // fontWeight: FontWeight.w600,
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
        ),
        const Spacer(
          flex: 15,
        ),
      ],
    );
  }
}
