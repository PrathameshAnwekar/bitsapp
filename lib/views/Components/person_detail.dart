import 'package:bitsapp/models/bits_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonDetail extends StatelessWidget {
  const PersonDetail({
    super.key,
    required this.user,
    required this.isSmall,
    required this.time,
  });
  final BitsUser user;
  final bool isSmall;
  final int? time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          user.name,
          style: GoogleFonts.roboto(
            color: const Color.fromRGBO(15, 15, 18, 0.9),
            fontSize: isSmall ? 16 : 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          time != null
              ? timeAgo(DateTime.fromMillisecondsSinceEpoch(time!))
              : "",
          style: GoogleFonts.roboto(
            color: const Color.fromARGB(255, 166, 166, 166),
            letterSpacing: 0.2,
            fontSize: isSmall ? 12.5 : 14.5,
          ),
        ),
      ],
    );
  }
}

String timeAgo(DateTime d) {
  Duration diff = DateTime.now().difference(d);
  if (diff.inDays > 365) {
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  }
  if (diff.inDays > 30) {
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  }
  if (diff.inDays > 7) {
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  }
  if (diff.inDays > 0) {
    return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
  }
  if (diff.inHours > 0) {
    return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
  }
  if (diff.inMinutes > 0) {
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
  }
  return "just now";
}
