import 'dart:async';
import 'dart:convert' show json;

import 'package:bitsapp/services/google_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

//write a function to sign in with google

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';
  @override
  State createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  Widget _buildBody(context) {
    User? user = GoogleAuthService.currentFirebaseUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email!),
          ),
          const Text('Signed in successfully.'),
          ElevatedButton(
            onPressed: () => GoogleAuthService().signOut(context).then((_) {
              setState(() {});
            }),
            child: const Text('SIGN OUT'),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          ElevatedButton(
            onPressed: () {
              try {
                GoogleAuthService().signIn(context).then((_) {
                  setState(() {});
                });
              } catch (e) {
                debugPrint(e.toString());
              }
            },
            child: const Text('SIGN IN'),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(context),
        ));
  }
}
