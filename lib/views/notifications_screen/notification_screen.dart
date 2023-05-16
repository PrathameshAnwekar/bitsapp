import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Notifications",
          style: GoogleFonts.inter(
            color: Colors.black.withOpacity(0.65),
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView.separated(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              "Title of Notification $index",
              style: GoogleFonts.inter(
                color: Colors.black.withOpacity(0.85),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              "Subtitle of Notification $index",
              style: GoogleFonts.inter(
                color: Colors.black.withOpacity(0.65),
                fontSize: 14,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(
          indent: 15,
          endIndent: 15,
          color: Color.fromARGB(255, 234, 236, 243),
          height: 1.5,
        ),
      ),
    );
  }
}
