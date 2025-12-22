import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:live_cric/utils/configs.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> flutterLocalNotificationInit() async {
    await flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationService.showNotification(message);
    });
  }

  static Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await Configs.messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else {
      await Permission.notification.request();
    }
  }

  static void showNotification(RemoteMessage message) async {
    if (message.data['title'] == null || message.data['body'] == null) return;
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'talksy',
          'Talksy',
          channelDescription: 'Daily winning notifications',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        );

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.data['title'],
      message.data['body'],
      platformChannelSpecifics,
    );
  }
}
