import 'package:bitsapp/controllers/auth_controller.dart';
import 'package:bitsapp/models/bits_user.dart';
import 'package:bitsapp/services/firestore_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GoogleAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignInAccount? googleSignInAccount;

  static Future<bool> signIn(context,WidgetRef ref) async {
    googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount != null &&
        googleSignInAccount!.email.contains("bits-pilani.ac.in")) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      UserCredential result = await _auth.signInWithCredential(authCredential);
      if (result.additionalUserInfo!.isNewUser) {
        await BitsUser.createNewUser(ref, result);
      }

      AuthController.currentActiveuser = result.user;
      return Future.value(true);
    } else {
      await _googleSignIn.disconnect();
      return Future.value(false);
    }
  }

  static Future<bool> signOut(BuildContext context) async {
    await _googleSignIn.disconnect();
    await _auth.signOut().then((_) {
      AuthController.currentActiveuser = null;
      return Future.value(true);
    });
    return Future.value(false);
  }

  
}
