

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// SHA1: EC:FF:45:39:A0:01:15:5A:CD:6E:29:09:41:47:F8:E3:85:3E:21:72
class PushNotificationServices {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream = StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message)async{
   print("background id ${message.messageId}");
    _messageStream.add( message.data['product'] ?? 'No data' );
  }

  static Future _onMessageHandler(RemoteMessage message)async{
   print("background id ${message.messageId}");
  }

    static Future _onMessageAppHandler(RemoteMessage message)async{
   print("background id ${message.messageId}");
  }

  static Future initMessaging()async{

    await Firebase.initializeApp();

    token = await FirebaseMessaging.instance.getToken();
     print("Token: ${token}");

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
      sound: true
    );

    print('User push notification status ${ settings.authorizationStatus }');

  }

}