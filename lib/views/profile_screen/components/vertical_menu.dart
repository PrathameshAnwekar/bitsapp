import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/models/user_experience.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../../constants/size_config.dart';

class VerticalMenu extends StatelessWidget {
  final List<UserExperience> userExperience;
  const VerticalMenu({
    super.key,
    required this.userExperience,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 2,
                  height: 55,
                  color: index == 0
                      ? Colors.transparent
                      : Constants.inactiveIconColor.withOpacity(0.6),
                ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Constants.kPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 2,
                  height: 55,
                  color: index == (userExperience.length - 1)
                      ? Colors.transparent
                      : Constants.inactiveIconColor.withOpacity(0.6),
                ),
              ],
            ),
            SimpleShadow(
              sigma: 5,
              color: Colors.grey.shade400,
              child: Container(
                width: SizeConfig.screenWidth * 0.75,
                margin: const EdgeInsets.only(left: 30),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                height: 110,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userExperience[index].title,
                      style: GoogleFonts.inter(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Visibility(
                      visible: (userExperience[index].description != ''),
                      child: Text(
                        userExperience[index].description,
                        style: GoogleFonts.inter(
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Text(
                      "Jun 2022 - Jul 2022 · 2 mos",
                      // userExperience[index].start.toString() +
                      //     userExperience[index].end.toString(),
                      style: GoogleFonts.roboto(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      itemCount: userExperience.length,
    );
  }
}
