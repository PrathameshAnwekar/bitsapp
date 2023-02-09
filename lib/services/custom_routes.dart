import 'package:bitsapp/views/auth/auth_screen.dart';
import 'package:bitsapp/services/initializer_service.dart';
import 'package:bitsapp/views/chat/chats_screen.dart';
import 'package:flutter/widgets.dart';

var customRoutes = <String, WidgetBuilder>{
  InitializerService.routeName: (context) => const InitializerService(),
  AuthScreen.routeName: (context) => const AuthScreen(),
  ChatsScreen.routeName: (context) => const ChatsScreen(),
}; 