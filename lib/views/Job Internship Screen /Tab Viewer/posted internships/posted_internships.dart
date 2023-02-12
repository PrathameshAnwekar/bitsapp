import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import 'posted_internships_details.dart';

class PostedInternships extends StatelessWidget {
  const PostedInternships({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => const PostedInternshipDetails()),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFFdfdee8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Social media manager",
                    style: GoogleFonts.dmSans(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w300,
                      // color: const Color.fromRGBO(248, 248, 253, 1),
                      fontSize: 22,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ReadMoreText(
                      "Planning and develpoing social media campaigns. Crafitng compelling content or getting it developed. Posting content across scocial media",
                      textAlign: TextAlign.start,
                      trimLines: 5,
                      trimMode: TrimMode.Line,
                      trimExpandedText: ' show less',
                      trimCollapsedText: ' ',
                      style: GoogleFonts.dmSans(
                        color: const Color(0xFF383D51),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 20,
        );
      },
      itemCount: 5,
    );
  }
}
