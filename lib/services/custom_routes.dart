import 'package:bitsapp/main.dart';
import 'package:bitsapp/views/auth/auth_screen.dart';
import 'package:bitsapp/views/bottom_nav_screen/bottom_nav_screen.dart';
import 'package:bitsapp/views/chat/chats_screen.dart';
import 'package:flutter/widgets.dart';

var customRoutes = <String, WidgetBuilder>{
  MyApp.routeName: (context) => const MyApp(),
  BottomBar.routeName: (context) =>  BottomBar(),
  AuthScreen.routeName: (context) => const AuthScreen(),
  ChatsScreen.routeName: (context) => const ChatsScreen(),
};
