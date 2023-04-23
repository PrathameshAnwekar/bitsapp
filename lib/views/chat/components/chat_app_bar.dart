import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatAppBar extends StatelessWidget with PreferredSizeWidget {
  const ChatAppBar({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        icon: SizedBox(
          height: 32,
          width: 32,
          child: SvgPicture.asset(
            "assets/icons/arrow_back.svg",
            color: Colors.black.withOpacity(0.65),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Center(
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
                  name,
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(SizeConfig.screenHeight * 0.08);
}
