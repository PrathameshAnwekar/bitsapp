import 'package:bitsapp/main.dart';
import 'package:bitsapp/views/auth/auth_screen.dart';
import 'package:bitsapp/views/bottom_nav_screen/bottom_nav_screen.dart';
import 'package:bitsapp/views/chat/chat.dart';
import 'package:bitsapp/views/chat/chats_screen.dart';
import 'package:flutter/widgets.dart';

var customRoutes = <String, WidgetBuilder>{
  MyApp.routeName: (context) =>  MyApp(),
  BottomNavScreen.routeName: (context) => const BottomNavScreen(),
  AuthScreen.routeName: (context) => const AuthScreen(),
  ChatsScreen.routeName: (context) => const ChatsScreen(),
  ChatRoomScreen.routeName: (context) => ChatRoomScreen(),
};
