// ignore_for_file: use_build_context_synchronously

import 'package:bitsapp/main.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/models/chat_room.dart';
import 'package:bitsapp/services/google_auth_service.dart';
import 'package:bitsapp/views/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthController {
  static signIn(BuildContext context, WidgetRef ref) async {
    final res = await GoogleAuthService.signIn(context, ref);
    if (res) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign-in successful!'),
        ),
      );
      Navigator.of(context)
          .pushNamedAndRemoveUntil(MyApp.routeName, (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Sign-in failed, please ensure a valid BITS email ID and internet connectivity!'),
        ),
      );
    }
  }

  static Future<void> signOut(BuildContext context, WidgetRef ref) async {
    final res = await GoogleAuthService.signOut();
    if (res) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign-out successful!'),
        ),
      );

      Navigator.of(context)
          .pushNamedAndRemoveUntil(AuthScreen.routeName, (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Sign-out failed, please ensure internet connectivity.'),
        ),
      );
      return Future.value(false);
    }
  }
}

clearPreviousUserData(WidgetRef ref) {
  ref.read(chatRoomsProvider.notifier).clear();
  ref.read(localUserProvider.notifier).clearUser();
}
