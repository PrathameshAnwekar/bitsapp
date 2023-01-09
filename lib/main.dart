import 'package:bitsapp/constants/init_constants.dart';
import 'package:bitsapp/utils/custom_routes.dart';
import 'package:bitsapp/utils/initializer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitConstants().init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BITSocial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const InitializerWidget(),
      routes: customRoutes,
    );
  }
}
