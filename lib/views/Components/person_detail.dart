import 'package:bitsapp/models/bits_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonDetail extends StatelessWidget {
  const PersonDetail({
    super.key,
    required this.user,
    required this.isSmall,
  });
  final BitsUser user;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          // user.name,
          "James Andrew",
          style: GoogleFonts.firaSans(
            color: const Color.fromRGBO(15, 15, 18, 0.9),
            fontSize: isSmall ? 16 : 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '1d ago',
          style: GoogleFonts.firaSans(
            color: const Color.fromARGB(255, 166, 166, 166),
            letterSpacing: 0.2,
            fontSize: isSmall ? 12.5 : 14.5,
          ),
        ),
      ],
    );
  }
}
