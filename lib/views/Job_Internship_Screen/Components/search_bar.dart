import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.manrope(
        color: Colors.white.withOpacity(0.9),
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      // focusNode: focusNode,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      cursorColor: Colors.grey,
      cursorRadius: const Radius.elliptical(2, 2),
      cursorWidth: 2,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(top: 21, left: 26, right: 12, bottom: 21),
        hintText: 'What are you looking for?',
        hintStyle: GoogleFonts.dmSans(
          fontSize: 18,
          color: Colors.white70,
        ),
        filled: true,
        // fillColor: const Color.fromRGBO(48, 48, 48, 1),
        fillColor: const Color.fromRGBO(49, 50, 54, 1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
