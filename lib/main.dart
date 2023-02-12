import 'package:bitsapp/constants/init_constants.dart';
import 'package:bitsapp/constants/size_config.dart';
import 'package:bitsapp/services/custom_routes.dart';
import 'package:bitsapp/services/firestore_service.dart';
import 'package:bitsapp/views/auth/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'views/bottom_nav_screen/bottom_nav_screen.dart';

bool init = true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitConstants().init();

  runApp(const ProviderScope(
      child: MediaQuery(data: MediaQueryData(), child: MyApp())));
}

class MyApp extends HookConsumerWidget {
  static const routeName = "/base-app";
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (init) {
      init = false;
      SizeConfig.init(context);
    }
    FirestoreService.initUser(ref);
    FirestoreService.updateContactsList(ref);
    FirestoreService.initialiseChatRooms(ref);

    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return SafeArea(
            child: MaterialApp(
              title: 'BITSocial',
              debugShowCheckedModeBanner: false,
              theme:
                  ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber),
              home: snapshot.hasData ? const BottomBar() : const AuthScreen(),
              // home: const BottomBar(),
              routes: customRoutes,
            ),
          );
        });
  }
}
