
import 'package:bitsapp/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//write a function to sign in with google

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: AuthController.currentActiveuser == null
              ? _signedOutBody(context)
              : _signedInBody(context),
        ));
  }

  Widget _signedOutBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const <Widget>[
        Text('You are not currently signed in.'),
        ElevatedButton(
          onPressed: null,
          child: Text('SIGN IN'),
        ),
      ],
    );
  }

  Widget _signedInBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        ListTile(
          title: Text(AuthController.currentActiveuser!.displayName ?? ''),
          subtitle: Text(AuthController.currentActiveuser!.email!),
        ),
        const Text('Signed in successfully.'),
        ElevatedButton(
          onPressed: () => AuthController.signOut(context),
          child: const Text('SIGN OUT'),
        ),
      ],
    );
  }
}
