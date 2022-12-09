import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String notificationChannelId = 'goblinmaster';
  int notificationId = 1;

  void init() {
    flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
        android: AndroidInitializationSettings('launch_background'),
        iOS: DarwinInitializationSettings()));
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      notificationChannelId,
      'OpticianApp Notifications',
      description: 'This channel is used for optician notifications.',
      importance: Importance.low,
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<bool?> requestPermission() async {
    var result = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    return await result;
  }

  void showNotification(String title, String body) async {
    /*bool? hasPermission = await requestPermission();
    if (hasPermission == null || !hasPermission) return;*/
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      '1',
      'goblinmaster',
      channelDescription: 'Optician-App',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: 'notification_icon'
    );
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: DarwinNotificationDetails());
    await flutterLocalNotificationsPlugin.show(
        notificationId++, title, body, notificationDetails);
  }
}
