import 'package:bitsapp/firebase_options.dart';
import 'package:bitsapp/services/fcm_service.dart';
import 'package:bitsapp/services/notif_service.dart';
import 'package:bitsapp/storage/hiveStore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InitConstants {
  init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FcmService.init();
    await NotifService.init().then((value) {
      NotifService.dismissAllNotifs();
    });
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // if (!kIsWeb) await FlutterDisplayMode.setHighRefreshRate();

    await HiveStore.init();
  }
}
