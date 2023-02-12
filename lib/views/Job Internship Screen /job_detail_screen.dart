import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'apply_now_screen.dart';

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            _personDetail(),
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
            _heading2("Skill(s) required", ""),
            Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              runSpacing: 6,
              spacing: 10,
              children: <Widget>[
                _tags("Python", 5, 10, 13),
                _tags("Machine Learning", 5, 10, 13),
                _tags("Data Structures and Algorithms", 5, 10, 13),
              ],
            ),
            const SizedBox(height: 10),
            _heading2("Compensation type : ", "Paid"),
          ],
        ),
      ),
      bottomNavigationBar: _bottomWidget(context),
    );
  }
}

Widget _heading2(String txt, String txt2) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          txt,
          style: const TextStyle(
            color: Color(0xFF4D5470),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        Text(
          txt2,
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontSize: 18,
          ),
        ),
      ],
    ),
  );
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

Widget _personDetail() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      CircleAvatar(
        radius: 15,
        backgroundColor: const Color.fromRGBO(226, 210, 254, 1),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SvgPicture.asset(
            'assets/Icons/person.svg',
            fit: BoxFit.cover,
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
    ],
  );
}

Widget _bottomWidget(BuildContext context) {
  return Material(
    elevation: 14,
    child: SizedBox(
      height: 90,
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => const ApplyNowScreen(
                    // circlecolor: const Color.fromRGBO(204, 240, 191, 1),
                    // logoUrl: 'assets/icons/freelance.svg',
                    // index: index,
                    )),
              ),
            );
          },
          child: Card(
            color: const Color(0xFF149fda),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            shadowColor: const Color(0xFF149fda).withOpacity(0.6),
            elevation: 6,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 16),
              child: Text(
                "Apply Now",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
