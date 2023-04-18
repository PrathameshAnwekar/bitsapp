import 'package:bitsapp/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../apply_now_screen.dart';

class ApplyNow extends StatelessWidget {
  const ApplyNow({
    super.key,
    required this.internshipUid,
  });
  final String internshipUid;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 14,
      child: SizedBox(
        height: 90,
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => ApplyNowScreen(
                        internshipUid: internshipUid,
                      )),
                ),
              );
            },
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
                    padding: const EdgeInsets.fromLTRB(35, 16, 4, 16),
                    child: Text(
                      "Apply Now",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.navigate_next_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  const SizedBox(width: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
