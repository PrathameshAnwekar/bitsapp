import 'package:bitsapp/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplyNow extends StatelessWidget {
  const ApplyNow({
    super.key,
    required this.onPressed,
    required this.text,
    required this.elevation,
    required this.alignment,
  });
  final VoidCallback onPressed;
  final String text;
  final double elevation;
  final MainAxisAlignment alignment;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: elevation,
      child: SizedBox(
        height: 90,
        child: Row(
          mainAxisAlignment: alignment,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Constants.kPrimaryColor,
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                child: Text(
                  "Back",
                  style: GoogleFonts.roboto(
                    color: Constants.kPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: onPressed,
              child: Card(
                color: Constants.kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                shadowColor: Constants.kPrimaryColor.withOpacity(0.8),
                elevation: 6,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 14,
                      ),
                      child: Text(
                        text,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
