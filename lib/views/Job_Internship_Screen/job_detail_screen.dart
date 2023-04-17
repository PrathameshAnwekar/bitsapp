import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/internship_data.dart';
import 'package:flutter/material.dart';

import '../components/circle_profile_pic.dart';
import '../components/person_detail.dart';
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
        scrolledUnderElevation: 0,
        leadingWidth: 40,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 28,
              color: Color(0xFF69708C),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Internship details",
          style: TextStyle(color: Color(0xFF4D5470), fontSize: 20),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Divider(
              thickness: 1,
              height: 15,
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const CircleProfilePic(radius: 16),
                const Spacer(flex: 1),
                PersonDetail(
                  user: poster,
                  isSmall: true,
                  time: internshipData.time,
                ),
                const Spacer(flex: 15),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              internshipData.title,
              style: TextStyle(
                // color: const Color(0xFF383D51).withOpacity(0.9),
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w700,
                fontSize: 24,
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
                  const Text(
                    "About Internship",
                    style: TextStyle(
                      color: Color(0xFF4D5470),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    internshipData.description,
                    style: TextStyle(
                      color: const Color(0xFF383D51).withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            const Heading2(txt1: "Skill(s) required", txt2: ""),
            Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              runSpacing: 6,
              spacing: 10,
              children: _tagBuilder(internshipData.skills),
            ),
            const SizedBox(height: 10),
            Heading2(
                txt1: "Compensation type : ",
                txt2: internshipData.compensation),
          ],
        ),
      ),
      bottomNavigationBar: ApplyNow(internshipUid: internshipData.uid),
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
