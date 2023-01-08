import 'package:bitsapp/constants/initConstants.dart';
import 'package:bitsapp/utils/customRoutes.dart';
import 'package:bitsapp/utils/initializerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitConstants().init();
    
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'BITSocial',
      theme: ThemeData(
      ),
      home: InitializerWidget(),
      routes: customRoutes,
    );
  }
}
