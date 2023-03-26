import 'package:bitsapp/constants/size_config.dart';
import 'package:bitsapp/views/auth/auth_screen.dart';
import 'package:bitsapp/views/bottom_nav_screen/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InitializerWidget extends ConsumerStatefulWidget {
  InitializerWidget({Key? key, required this.snapshot1, required this.snapshot})
      : super(key: key);
  final snapshot1, snapshot;
  static const routeName = '/initializer';
  @override
  ConsumerState<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends ConsumerState<InitializerWidget> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return LayoutBuilder(
        builder: (context, orientation) {
          SizeConfig().init(context);

          return (widget.snapshot1.connectionState == ConnectionState.waiting ||
                  widget.snapshot1.connectionState == ConnectionState.none)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : widget.snapshot.hasData
                  ? const BottomBar()
                  : const AuthScreen();
        },
      );
    });
  }
}
