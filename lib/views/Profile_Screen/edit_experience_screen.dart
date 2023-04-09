import 'package:bitsapp/views/profile_screen/components/divider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/data_widget.dart';

class ExperienceEditScreen extends StatelessWidget {
  const ExperienceEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          "Edit Experience",
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
              const ExperienceWidget(
                url: "https://jep-asset.akamaized.net/jio/svg-og/jio_logo.png",
                txt1: "Summer Intern",
                txt2: "Jio Platforms Limited · Internship",
                txt3: "Jun 2022 - Jul 2022 · 2 mos",
                showEdit: true,
              ),
              div(),
              const ExperienceWidget(
                url:
                    "https://media.licdn.com/dms/image/C4D0BAQF4FNXeLIGIaA/company-logo_100_100/0/1628696386405?e=1684972800&v=beta&t=gxswQ2V7FRmjIZwRAp129CzoW4_xWlhxXWI2bUY_R3Q",
                txt1: "App Developer",
                txt2: "Rentalz · Part-time",
                txt3: "Sep 2021 - Feb 2022 · 6 mos",
                showEdit: true,
              ),
              div(),
              const ExperienceWidget(
                url:
                    "https://media.licdn.com/dms/image/C4E0BAQGJ6Z9crpkcXw/company-logo_100_100/0/1629550065724?e=1684972800&v=beta&t=KKLx6qZHKGmK1n2YingHh-WdO-x6jHif5hzfSSWsWok",
                txt1: "Summer Intern",
                txt2: "CRISS Robotics · Internship",
                txt3: "Jul 2021 - Feb 2022 · 8 mos",
                showEdit: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

shpowPopUp(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog();
      },
    );
