import 'package:bitsapp/constants/init_constants.dart';
import 'package:bitsapp/services/custom_routes.dart';
import 'package:bitsapp/services/firestore_service.dart';
import 'package:bitsapp/views/initializer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:month_year_picker/month_year_picker.dart';

bool init = true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitConstants().init();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  static const routeName = "/base-app";
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: FirestoreService.initEverything(ref, context),
      builder: (context, snapshot1) {
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            return MaterialApp(
              localizationsDelegates: const [
                MonthYearPickerLocalizations.delegate,
              ],
              title: 'BITSocial',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true,
                colorSchemeSeed: Colors.amber,
                appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                    statusBarBrightness: Brightness.light,
                  ),
                ),
              ),
              home: InitializerWidget(snapshot1: snapshot1, snapshot: snapshot),
              routes: customRoutes,
            );
          },
        );
      },
    );
  }
}
