import 'dart:io';

import 'package:bitsapp/firebase_options.dart';
import 'package:bitsapp/services/fcm_service.dart';
import 'package:bitsapp/services/notif_service.dart';
import 'package:bitsapp/storage/hiveStore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:motion/motion.dart';

class InitConstants {
  init() async {
    await Motion.instance.initialize();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await NotifService.init().then((value) {
      NotifService.dismissAllNotifs();
    });
    //set notif panel to transpaernt
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    if (Platform.isAndroid) await FlutterDisplayMode.setHighRefreshRate();

    await HiveStore.init();
    FcmService.init();
  }
}
