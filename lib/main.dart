import 'package:bitsapp/constants/init_constants.dart';
import 'package:bitsapp/services/custom_routes.dart';
import 'package:bitsapp/services/initializer_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.amber
      ),
      home: const InitializerService(),
      routes: customRoutes,
    );
  }
}
