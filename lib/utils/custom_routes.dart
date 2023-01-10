import 'package:bitsapp/screens/auth/login_screen.dart';
import 'package:bitsapp/utils/initializer_widget.dart';
import 'package:flutter/widgets.dart';

var customRoutes = <String, WidgetBuilder>{
  InitializerWidget.routeName: (context) => const InitializerWidget(),
  LoginScreen.routeName: (context) => const LoginScreen(),
}; 