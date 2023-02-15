import 'package:bitsapp/views/job_internship_screen/Components/person_detail.dart';
import 'package:flutter/material.dart';

import '../Components/circle_profile_pic.dart';
import 'Components/apply_now.dart';
import 'components/heading2.dart';
import 'components/tags.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});

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
        backgroundColor: const Color(0xFFF7F6F8),
        title: const Text(
          "Internship details",
          style: TextStyle(color: Color(0xFF4D5470), fontSize: 20),
        ),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF7F6F8),
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
              children: const [
                CircleProfilePic(radius: 16),
                Spacer(flex: 1),
                PersonDetail(),
                Spacer(flex: 15),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Social Media Manager",
              style: TextStyle(
                // color: const Color(0xFF383D51).withOpacity(0.9),
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            Container(
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
                    "Planning and develpoing social media campaigns. Crafitng compelling content or getting it developed. Posting content across scocial media accounts. Enaging with customers on different channels. Analzing running campaigns. Being on top of the latest social media trends",
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
            const SizedBox(height: 10),
            const Heading2(txt1: "Compensation type : ", txt2: "Paid"),
          ],
        ),
      ),
      bottomNavigationBar: const ApplyNow(),
    );
  }
}
