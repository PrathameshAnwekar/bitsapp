import 'package:bitsapp/firebase_options.dart';
import 'package:bitsapp/storage/hiveStore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

class InitConstants {
  init() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await HiveStore.init();
  }
}
