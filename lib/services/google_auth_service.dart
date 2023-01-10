import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignInAccount? googleSignInAccount;
  static User? currentFirebaseUser = null;

  signIn(context) async {
    googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      if (googleSignInAccount!.email.contains("bits-pilani.ac.in")) {
        ///EMAIL VERIFICATION
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount!.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        UserCredential result =
            await _auth.signInWithCredential(authCredential);
        currentFirebaseUser = result.user;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign-in successful!'),
          ),
        );
      } else {
        _googleSignIn.disconnect();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign in failed, please use your BITS email ID'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign in failed'),
        ),
      );
    }
  }

  signOut(context) async {
    await _googleSignIn.disconnect();
    await _auth.signOut().then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign-out successful!'),
        ),
      );
      currentFirebaseUser = null;
    });
  }
}
