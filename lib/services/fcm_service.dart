import 'package:bitsapp/services/firestore_service.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

class FcmService {
  static final _fcm = FirebaseMessaging.instance;

  static void init() {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      dlog("message recieved");
      dlog(event.notification!.body!);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      dlog('Message clicked!');
    });
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  static void updateToken() async {
    await _fcm.getToken().then((value) async {
      await FirestoreService.updateFcmToken(value!);
      dlog(value);
    });
  }
}
