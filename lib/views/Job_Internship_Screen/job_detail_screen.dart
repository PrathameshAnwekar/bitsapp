import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/internship_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/circle_profile_pic.dart';
import '../components/person_detail.dart';
import 'apply_now_screen.dart';
import 'components/apply_now.dart';
import 'components/heading2.dart';
import 'components/tags.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen(
      {super.key, required this.internshipData, required this.poster});
  final InternshipData internshipData;
  final BitsUser poster;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(5),
          child: Divider(
            thickness: 1,
            height: 10,
            endIndent: 22,
            indent: 22,
          ),
        ),
        scrolledUnderElevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "Internship details",
          style: GoogleFonts.roboto(
            color: Colors.black.withOpacity(0.7),
            fontSize: 20,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            Row(
              children: [
                const CircleProfilePic(radius: 21),
                const Spacer(flex: 1),
                PersonDetail(
                  user: poster,
                  isSmall: false,
                  time: internshipData.time,
                ),
                const Spacer(flex: 15),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              internshipData.title,
              style: GoogleFonts.roboto(
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFFdfdee8).withOpacity(0.8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "About Internship",
                    style: GoogleFonts.roboto(
                      color: const Color(0xFF4D5470),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    internshipData.description,
                    style: GoogleFonts.roboto(
                      fontSize: 14.5,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            const Heading2(txt1: "Skill(s) required :", txt2: ""),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                runSpacing: 6,
                spacing: 10,
                children: _tagBuilder(internshipData.skills),
              ),
            ),
            Heading2(
              txt1: "Compensation type : ",
              txt2: internshipData.compensation,
            ),
          ],
        ),
      ),
      bottomNavigationBar: ApplyNow(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: ((context) => ApplyNowScreen(
                  internshipUid: internshipData.uid,
                )),
          ),
        ),
        text: "Apply Now",
        elevation: 14,
        alignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }

  List<Tags> _tagBuilder(List<String> tags) {
    final List<Tags> tagList = [];
    for (final tag in tags) {
      tagList.add(
        Tags(
          text: tag,
          inPadding: 5,
          borderRadius: 10,
          textSize: 13,
        ),
      );
    }
    return tagList;
  }
}
