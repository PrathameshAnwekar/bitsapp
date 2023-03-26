import 'package:flutter/material.dart';

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
      backgroundImage: const NetworkImage(
        "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
      ),
    );
  }
}
