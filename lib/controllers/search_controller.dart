import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/views/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';

class SearchController {
  static void goToUserProfile(BuildContext context, BitsUser user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen(user)),
    );
  }
}
