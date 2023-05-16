import 'package:bitsapp/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/constants.dart';

class ChannelAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChannelAppBar({
    Key? key,
    required this.channelName,
  }) : super(key: key);
  final String channelName;

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
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Padding(
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
              Text(
                channelName,
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(SizeConfig.screenHeight * 0.08);
}
