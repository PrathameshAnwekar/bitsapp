import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/data_widget.dart';
import 'components/divider.dart';

class EducationEditScreen extends StatelessWidget {
  const EducationEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          "Edit Education",
          style: GoogleFonts.dmSans(
            color: Colors.black.withOpacity(0.65),
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.xmark,
            color: Colors.black.withOpacity(0.65),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.plus,
              color: Colors.black.withOpacity(0.65),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // const ExperienceWidget(
              //   url:
              //       "https://media.licdn.com/dms/image/C510BAQFYyp6NIc6n2A/company-logo_100_100/0/1539083994824?e=1684972800&v=beta&t=XdAP4lWl6r1I2NMtcvmoJBoCAJ9IGgpQjUYF5fEdG5w",
              //   txt1: "Bits Pilani",
              //   txt2: "Electronics and Instrumentation",
              //   txt3: "2022 - 2024",
              //   showEdit: true,
              // ),
              // div(),
              // const ExperienceWidget(
              //   url:
              //       "https://imgs.search.brave.com/YXw_8nP0SsLihynYGUbasNPbeLL4szRrTqjONaMmYq8/rs:fit:225:225:1/g:ce/aHR0cHM6Ly90c2Uy/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5Z/YWcwLUNCN2ktZG5s/aFlFRlh2U0dnQUFB/QSZwaWQ9QXBp",
              //   txt1: "Camford International School",
              //   txt2: "2018-2020",
              //   txt3: "",
              //   showEdit: true,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
