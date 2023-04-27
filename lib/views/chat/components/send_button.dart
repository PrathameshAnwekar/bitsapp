import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/constants.dart';

class SendButton extends StatelessWidget {
  const SendButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 15, 16, 15),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Constants.kPrimaryColor,
        gradient: LinearGradient(
          colors: [
            Constants.kPrimaryColor.withOpacity(0.76),
            Constants.kPrimaryColor
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: SvgPicture.asset(
        "assets/icons/share_filled.svg",
        width: 28,
        height: 28,
        color: Colors.white,
      ),
    );
  }
}
