import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleProfilePic extends StatelessWidget {
  const CircleProfilePic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 15,
      backgroundColor: const Color.fromRGBO(226, 210, 254, 1),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SvgPicture.asset(
          'assets/Icons/person.svg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
