import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleProfilePic extends StatelessWidget {
  final double radius;
  const CircleProfilePic({
    super.key,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color.fromRGBO(226, 210, 254, 1),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SvgPicture.asset(
          'assets/icons/person.svg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
