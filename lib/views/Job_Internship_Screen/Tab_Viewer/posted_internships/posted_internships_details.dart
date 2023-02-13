import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/heading2.dart';
import '../../components/tags.dart';

class PostedInternshipDetails extends StatelessWidget {
  const PostedInternshipDetails({super.key});

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
          "Responses",
          style: TextStyle(color: Color(0xFF4D5470), fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit_note_rounded,
              color: Color(0xFF4D5470),
              size: 28,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.archive_rounded,
              color: Colors.lightGreen,
              size: 28,
            ),
          )
        ],
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF7F6F8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            _expandable(),
            Expanded(child: _listView()),
          ],
        ),
      ),
    );
  }
}

Widget _expandable() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
    margin: const EdgeInsets.symmetric(vertical: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: const Color(0xFFdfdee8).withOpacity(0.8),
    ),
    child: ExpandablePanel(
      header: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          "Details",
          style: TextStyle(
            color: Color(0xFF4D5470),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      theme: ExpandableThemeData(
        iconColor: Colors.black.withOpacity(0.8),
        iconSize: 26,
      ),
      collapsed: const SizedBox(),
      expanded: Column(
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
            child: Text(
              "Planning and develpoing social media campaigns. Crafitng compelling content or getting it developed. Posting content across scocial media",
              textAlign: TextAlign.start,
              style: GoogleFonts.dmSans(
                color: const Color(0xFF383D51),
                fontSize: 16,
              ),
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
                text: "Data Structures and Algorithms",
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
  );
}

Widget _listView() {
  return ListView.separated(
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFFdfdee8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Prathamesh Anwekar",
                style: TextStyle(fontSize: 16),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.chat_rounded,
                  size: 26,
                ),
              )
            ],
          ),
        ),
      );
    },
    separatorBuilder: (BuildContext context, int index) {
      return const SizedBox(
        height: 10,
      );
    },
    itemCount: 5,
  );
}
