import 'package:bitsapp/constants/sizeConfig.dart';
import 'package:bitsapp/storage/sharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InitializerWidget extends ConsumerStatefulWidget {
  const InitializerWidget({Key? key}) : super(key: key);
  static const routeName = '/initializer';
  @override
  ConsumerState<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends ConsumerState<InitializerWidget> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(builder: (context, orientation) {
          SizeConfig().init(context);

          if (SharedPrefs.getString("userId") == null) {
            // return SplashScreen(route: Onboarding.routeName);
          } else {
            // return Home();
          }
          return CircularProgressIndicator();
        });
      },
    );
  }
}
