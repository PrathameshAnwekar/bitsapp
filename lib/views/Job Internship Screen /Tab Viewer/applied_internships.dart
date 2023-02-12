import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../job_detail_screen.dart';

class AppliedInternships extends StatelessWidget {
  const AppliedInternships({super.key});
  @override
  Widget build(BuildContext context) {
    final statusList = [
      ["Accepted", Colors.green],
      ["Pending", Colors.yellow.shade700],
      ["Rejected", Colors.red],
    ];
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
                  children: <Widget>[
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: const Color.fromRGBO(226, 210, 254, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: SvgPicture.asset(
                          'assets/person.svg',
                          fit: BoxFit.cover,
                          color: const Color.fromRGBO(54, 50, 60, 1),
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
                    _tags("Paid", 4, 15, 13),
                    const SizedBox(width: 10),
                    _tags("Equity", 4, 15, 13),
                    // _tags("Revenue Split", 2, 15, 10)
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
                  children: <Widget>[
                    _tags("Python", 5, 10, 13),
                    _tags("Machine Learning", 5, 10, 13),
                    _tags("Dsa", 5, 10, 13),
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
                    _applicationStatus(statusList[index % 3][0] as String,
                        statusList[index % 3][1] as Color),
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

Widget _tags(
    String text, double inPadding, double borderRadius, double textSize) {
  return Container(
    padding: EdgeInsets.all(inPadding),
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.black.withOpacity(0.7),
      ),
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: Text(
      text,
      style: GoogleFonts.dmSans(
        color: Colors.black.withOpacity(0.7),
        fontSize: textSize,
      ),
    ),
  );
}

Widget _applicationStatus(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
    decoration: BoxDecoration(
      border: Border.all(
        color: color,
      ),
      color: color,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: GoogleFonts.dmSans(
        color: Colors.white,
        fontSize: 14,
      ),
    ),
  );
}
