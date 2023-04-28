import 'dart:io';

import 'package:bitsapp/firebase_options.dart';
import 'package:bitsapp/services/fcm_service.dart';
import 'package:bitsapp/services/notif_service.dart';
import 'package:bitsapp/storage/hiveStore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class InitConstants {
  static init() async {
    await HiveStore.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    await NotifService.init().then((value) {
      NotifService.dismissAllNotifs();
    });

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    if (Platform.isAndroid) await FlutterDisplayMode.setHighRefreshRate();

    FcmService.init();
  }
}
