import 'package:bitsapp/constants/size_config.dart';
import 'package:bitsapp/views/auth/auth_screen.dart';
import 'package:bitsapp/services/google_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../views/bottom_nav_screen/bottom_nav_screen.dart';

class InitializerService extends ConsumerStatefulWidget {
  const InitializerService({Key? key}) : super(key: key);
  static const routeName = '/initializer';
  @override
  ConsumerState<InitializerService> createState() => _InitializerServiceState();
}

class _InitializerServiceState extends ConsumerState<InitializerService> {
  bool init = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OrientationBuilder(
        builder: (context, orientation) {
          return LayoutBuilder(builder: (context, orientation) {
              return AuthScreen();
          });
        },
      ),
    );
  }
}
