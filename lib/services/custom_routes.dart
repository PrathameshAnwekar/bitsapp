import 'package:bitsapp/views/auth/auth_screen.dart';
import 'package:bitsapp/services/initializer_service.dart';
import 'package:flutter/widgets.dart';

var customRoutes = <String, WidgetBuilder>{
  InitializerService.routeName: (context) => const InitializerService(),
  AuthScreen.routeName: (context) => const AuthScreen(),
}; 