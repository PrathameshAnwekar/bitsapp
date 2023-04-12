import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:bitsapp/models/recieved_notification.dart';
import 'package:bitsapp/services/logger_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

final serverUrl = "clownfish-app-iz2im.ondigitalocean.app";

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  dlog('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_dlog
    dlog(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

class NotifService {
  static final FlutterLocalNotificationsPlugin _notif =
      FlutterLocalNotificationsPlugin();
  static final BehaviorSubject<String> behaviorSubject = BehaviorSubject();
  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  static const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);

  static const InitializationSettings initializationSettings =
      InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  static Future<bool> init() async {
    bool permission = await requestPermission() ?? false;
    if (permission) {
      await _notif.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
          // handle action
          dlog("Notification tapped");
        },
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      );
    }
    return Future.value(true);
  }

  static requestPermission() async {
    if (Platform.isIOS) {
      return _notif
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()!
          .requestPermissions();
    } else {
      return _notif
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestPermission();
    }
  }

  static void dismissAllNotifs() async {
    await _notif.cancelAll();
  }

  static void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    dlog('IOS notification: id $id, paylod $payload');
  }

  static void selectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      behaviorSubject.add(payload);
    }
  }

  static Future<NotificationDetails> _notificationDetails() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'channel id',
      'channel name',
      groupKey: 'com.example.flutter_push_notifications',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      color: Color(0xff2196f3),
    );

    DarwinNotificationDetails iosNotificationDetails =
        const DarwinNotificationDetails(
      threadIdentifier: "bitsappThread",
    );

    final details = await _notif.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      behaviorSubject.add(details.notificationResponse!.payload!);
    }
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);

    return platformChannelSpecifics;
  }

  static Future<void> showLocalNotification(
      ReceivedNotification notification) async {
    final platformChannelSpecifics = await _notificationDetails();
    await _notif.show(
      notification.id,
      notification.title,
      notification.body,
      platformChannelSpecifics,
      payload: notification.payload,
    );
  }

  static Future<void> sendChatNotification(
      {required String text,
      required String sender,
      required String token}) async {
    // var url = Uri.parse(
    //     'https://$serverUrl/chat?sender=$sender&token=$token&text=$text');
    // var response = await http.get(url);
    // dlog("Sent get request to $url");
    // if (response.statusCode == 200) {
    //   if (response.body.isNotEmpty) {
    //     // final jsonResponse = json.decode(response.body);
    //     print('Response: ${response.statusCode}');
    //   }
    // } else {
    //   print('Request failed with status: ${response.statusCode}.');
    // }
  }

  static Future<void> sendPostNotification(
      {required String text, required String sender}) async {
    // var url = Uri.parse('https://$serverUrl/topic?sender=$sender&text=$text');
    // var response = await http.get(url);
    // dlog("Sent get request to $url");
    // if (response.statusCode == 200) {
    //   // var jsonResponse = json.decode(response.body);
    //   print('Response: ${response.statusCode}');
    // } else {
    //   print('Request failed with status: ${response.statusCode}.');
    // }
  }
}
