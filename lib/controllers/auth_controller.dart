// ignore_for_file: use_build_context_synchronously

import 'package:bitsapp/services/google_auth_service.dart';
import 'package:bitsapp/views/bottom_nav_screen/bottom_nav_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthController {
  static User? currentActiveuser;
  static signIn(BuildContext context, WidgetRef ref) async {
    final res = await GoogleAuthService.signIn(context, ref);
    if (res) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign-in successful!'),
        ),
      );
      Navigator.of(context)
          .pushNamedAndRemoveUntil(BottomBar.routeName, (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Sign-in failed, please ensure a valid BITS email ID and internet connectivity!'),
        ),
      );
    }
  }

  static Future<bool> signOut(BuildContext context) async {
    final res = await GoogleAuthService.signOut();
    if (res) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign-out successful!'),
        ),
      );
      currentActiveuser = null;
      return Future.value(true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Sign-out failed, please ensure internet connectivity!'),
        ),
      );
      return Future.value(false);
    }
  }
}
