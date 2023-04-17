import 'package:bitsapp/constants/constants.dart';
import 'package:bitsapp/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatAppBar extends StatelessWidget with PreferredSizeWidget {
  const ChatAppBar({
    super.key, required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 63,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      centerTitle: false,
      titleSpacing: 0.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
                "Online Now",
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight( SizeConfig.screenHeight * 0.07);
}
