import 'package:bitsapp/views/Components/person_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../../Components/circle_profile_pic.dart';

class FeedContainer extends StatelessWidget {
  const FeedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const [
              CircleProfilePic(),
              Spacer(flex: 1),
              PersonDetail(),
              Spacer(flex: 25),
              Icon(
                Icons.more_vert_outlined,
                color: Color.fromRGBO(32, 33, 37, 1),
                size: 24,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ReadMoreText(
              "widget.desc",
              textAlign: TextAlign.start,
              colorClickableText: Colors.grey,
              style: GoogleFonts.manrope(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
