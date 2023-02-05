import 'package:bitsapp/constants/size_config.dart';
import 'package:bitsapp/screens/auth/login_screen.dart';
import 'package:bitsapp/services/google_auth_service.dart';
import 'package:bitsapp/storage/sharedPrefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../screens/Bottom Nav Screen/bottom_nav_screen.dart';

class InitializerWidget extends ConsumerStatefulWidget {
  const InitializerWidget({Key? key}) : super(key: key);
  static const routeName = '/initializer';
  @override
  ConsumerState<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends ConsumerState<InitializerWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OrientationBuilder(
        builder: (context, orientation) {
          return LayoutBuilder(builder: (context, orientation) {
            SizeConfig().init(context);
            if (FirebaseAuth.instance.currentUser == null) {
              return LoginScreen();
            }
            return const BottomNavScreen();
          });
        },
      ),
    );
  }
}
