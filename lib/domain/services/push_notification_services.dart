// ignore_for_file: library_prefixes

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

// SHA1: EC:FF:45:39:A0:01:15:5A:CD:6E:29:09:41:47:F8:E3:85:3E:21:72
class PushNotificationServices {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream =
      StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future _onMessageHandler(RemoteMessage message) async {}

  static Future _onMessageAppHandler(RemoteMessage message) async {}

  static Future initMessaging() async {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCrcD3qfJQRL9iAxY_RURWFjqzz8qYFP0s",
            projectId: "ambient-ec3df",
            messagingSenderId: "613674444074",
            appId: "1:613674444074:android:e00cd5a7aa6f693199ea53"));

    token = await FirebaseMessaging.instance.getToken();
    requestPermission();
    setupLocalNotification();

    FirebaseMessaging.onMessage.listen((_onMessageHandler));
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageAppHandler);
  }

  static requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
  }

  static setupLocalNotification() async {
    final localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // #1
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');

    // #2
    const initSettings = InitializationSettings(android: androidSetting);

    // #3
    await localNotificationsPlugin.initialize(initSettings).then((_) {
      debugPrint('setupPlugin: setup success');
    }).catchError((Object error) {
      debugPrint('Error: $error');
    });
  }

  static sendLocalNotification(
      {required String idNotification,
      required String nameNotification,
      required int dateId,
      required int endTime}) async {
// #1
    final localNotificationsPlugin = FlutterLocalNotificationsPlugin();

    tzData.initializeTimeZones();
    final scheduleTime =
        tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, endTime);

// #2
    final androidDetail = AndroidNotificationDetails(
      idNotification, // channel Id
      nameNotification, // channel Name
      color: Colors.purple[900],
    );

    final noticeDetail = NotificationDetails(
      android: androidDetail,
    );

// #3
    await localNotificationsPlugin.zonedSchedule(
      dateId,
      nameNotification,
      "PODCAST ACTIVO",
      scheduleTime,
      noticeDetail,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  static cancelAllLocalNotifications() {
    final localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    localNotificationsPlugin.cancelAll();
  }

  static stateLocalNotifications() async {
    final localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    List list = await localNotificationsPlugin.getActiveNotifications();
    return list.isEmpty ? true : false;
  }
}
