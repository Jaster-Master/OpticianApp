import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void init(){
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
      android: AndroidInitializationSettings('launch_background')
    ));
  }

  Future<bool?> requestPermission() async {
    var result = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    return await result;
  }

  void showNotification(String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('1', 'goblinmaster',
            channelDescription: 'Optician-App',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, notificationDetails);
  }
}
