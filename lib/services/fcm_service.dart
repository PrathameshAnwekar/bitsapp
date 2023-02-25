import 'package:bitsapp/models/recieved_notification.dart';
import 'package:bitsapp/services/firestore_service.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bitsapp/services/notif_service.dart';

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  dlog('background message ${message.notification!.body}');
}

class FcmService {
  static final _fcm = FirebaseMessaging.instance;

  static init() async {
   final settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      dlog("message recieved");
      dlog(event.notification!.body!);
      final notif = event.notification;
      NotifService.showLocalNotification(
        ReceivedNotification(id: 0, title: notif!.title!, body: notif.body!, payload: event.messageType)
      );
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

  // static Future<void> sendChatNotification(String fcmToken) async {
  //   return await _fcm.sendMessage(
  //     to: "cZiB2MlmTt6Zq_sJhFCos-:APA91bGmVv3M8pAUqUmhxEePe5jmhn1cNsgABw4lNO20tdMlQJRvJAMgQqtL1963qtpFjp2rCPw7uigmm0cyCd5j_4lCQAalLyhLNuXBWTTkmSAOOdwyazDYDVnk9vq0k7mwAOe1nF3G",
  //     data: {
  //       'title': 'New Message',
  //       'body': 'You have a new message',
  //     },
  //     collapseKey: "collapse_key",
  //     messageId: "0",
  //   );
  // }
}
