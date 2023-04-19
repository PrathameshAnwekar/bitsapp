import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.roboto(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: const Color.fromARGB(255, 168, 168, 168),
      ),
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      cursorColor: Colors.grey,
      cursorRadius: const Radius.elliptical(2, 2),
      cursorWidth: 2,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 17, bottom: 17),
          child: SvgPicture.asset(
            'assets/icons/search.svg',
            color: Colors.blueGrey.shade700,
          ),
        ),
        contentPadding: const EdgeInsets.only(top: 14, right: 12, bottom: 14),
        hintText: 'What are you looking for?',
        hintStyle: GoogleFonts.roboto(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: const Color.fromARGB(255, 168, 168, 168),
        ),
        filled: true,
        // fillColor: const Color.fromRGBO(48, 48, 48, 1),
        // fillColor: const Color.fromRGBO(49, 50, 54, 1),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
