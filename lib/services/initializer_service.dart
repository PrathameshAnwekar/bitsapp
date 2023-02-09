import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/size_config.dart';
import '../views/Bottom Nav Screen/bottom_nav_screen.dart';

class InitializerService extends ConsumerStatefulWidget {
  const InitializerService({Key? key}) : super(key: key);
  static const routeName = '/initializer';
  @override
  ConsumerState<InitializerService> createState() => _InitializerServiceState();
}

class _InitializerServiceState extends ConsumerState<InitializerService> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OrientationBuilder(
        builder: (context, orientation) {
          return LayoutBuilder(builder: (context, orientation) {
            SizeConfig.init(context);
            // if (FirebaseAuth.instance.currentUser == null) {
            //   return const AuthScreen();
            // }
            return const BottomNavScreen();
          });
        },
      ),
    );
  }
}
