import 'package:bitsapp/constants/size_config.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../../constants/constants.dart';
import '../../profile_screen/profile_screen.dart';

class ChatAppBar extends StatelessWidget with PreferredSizeWidget {
  const ChatAppBar({
    super.key,
    required this.otherUser,
  });
  final BitsUser otherUser;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Container(
          margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
          height: 32,
          width: 32,
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black.withOpacity(0.65),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: GestureDetector(
        onTap: () => Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: ProfileScreen(otherUser),
            childCurrent: this,
            duration: const Duration(milliseconds: 250),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.015),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 23,
                  backgroundImage: AssetImage("assets/images/user2.png"),
                ),
                const SizedBox(width: Constants.kDefaultPadding * 0.75),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      otherUser.name,
                      style: GoogleFonts.dmSans(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "● Online",
                      style: GoogleFonts.dmSans(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(SizeConfig.screenHeight * 0.08);
}
