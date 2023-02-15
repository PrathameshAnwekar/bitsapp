import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../../../../constants/constants.dart';
import '../../../Components/circle_profile_pic.dart';
import '../../../Components/person_detail.dart';
import '../../Components/application_status.dart';
import '../../components/tags.dart';
import '../../job_detail_screen.dart';

class AppliedInternships extends StatelessWidget {
  const AppliedInternships({super.key});
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
            // height: 140,
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
                    CircleProfilePic(radius: 16),
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
                const Divider(
                  height: 22,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Applied on June ${index * 3 + index % 3 + 2}, 9:07 AM",
                      style: const TextStyle(fontSize: 14),
                    ),
                    ApplicationStatus(
                      text: Constants.statusList[index % 3][0] as String,
                      color: Constants.statusList[index % 3][1] as Color,
                    ),
                  ],
                )
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
      itemCount: 6,
    );
  }
}
