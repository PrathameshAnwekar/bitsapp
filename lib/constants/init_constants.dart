import 'package:bitsapp/firebase_options.dart';
import 'package:bitsapp/storage/sharedPrefs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

class InitConstants {
  init() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    if (!kIsWeb) await FlutterDisplayMode.setHighRefreshRate();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await SharedPrefs.init();
  }
}
