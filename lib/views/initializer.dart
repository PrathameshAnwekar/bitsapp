import 'package:bitsapp/constants/size_config.dart';
import 'package:bitsapp/views/auth/auth_screen.dart';
import 'package:bitsapp/views/bottom_nav_screen/bottom_nav_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InitializerWidget extends ConsumerStatefulWidget {
  const InitializerWidget({Key? key, required this.initSnapshot})
      : super(key: key);
  final initSnapshot;
  static const routeName = '/initializer';
  @override
  ConsumerState<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends ConsumerState<InitializerWidget> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(
          builder: (context, orientation) {
            SizeConfig().init(context);
            return (widget.initSnapshot.connectionState ==
                        ConnectionState.waiting ||
                    widget.initSnapshot.connectionState == ConnectionState.none)
                ? const Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : FirebaseAuth.instance.currentUser != null
                    ? const BottomBar()
                    : const AuthScreen();
          },
        );
      },
    );
  }
}
