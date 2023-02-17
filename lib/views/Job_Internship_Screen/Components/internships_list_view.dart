import 'package:bitsapp/views/Components/circle_profile_pic.dart';
import 'package:bitsapp/views/Components/person_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../job_detail_screen.dart';
import 'tags.dart';

class InternshipsListView extends StatelessWidget {
  const InternshipsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => const JobDetailScreen()),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFFdfdee8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    CircleProfilePic(),
                    Spacer(flex: 1),
                    PersonDetail(),
                    Spacer(flex: 15),
                    Tags(
                      text: "Paid",
                      inPadding: 4,
                      borderRadius: 15,
                      textSize: 13,
                    ),
                    SizedBox(width: 10),
                    Tags(
                      text: "Equity",
                      inPadding: 4,
                      borderRadius: 15,
                      textSize: 13,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  "Social media manager",
                  style: GoogleFonts.dmSans(
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.w300,
                    // color: const Color.fromRGBO(248, 248, 253, 1),
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 12),
                ReadMoreText(
                  "Planning and develpoing social media campaigns. Crafitng compelling content or getting it developed. Posting content across scocial media",
                  textAlign: TextAlign.start,
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: ' show less',
                  trimCollapsedText: ' ',
                  style: GoogleFonts.dmSans(
                    color: const Color(0xFF383D51),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  runSpacing: 6,
                  spacing: 10,
                  children: const <Widget>[
                    Tags(
                      text: "Python",
                      inPadding: 5,
                      borderRadius: 10,
                      textSize: 13,
                    ),
                    Tags(
                      text: "Machine Learning",
                      inPadding: 5,
                      borderRadius: 10,
                      textSize: 13,
                    ),
                    Tags(
                      text: "Dsa",
                      inPadding: 5,
                      borderRadius: 10,
                      textSize: 13,
                    ),
                  ],
                ),
              ],
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
