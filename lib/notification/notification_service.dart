import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:opticianapp/notification/notification_handler.dart';

class NotificationService {
  NotificationHandler notificationHandler;
  String notificationChannelId = 'goblinmaster';
  int notificationId = 1;

  NotificationService(this.notificationHandler, this.notificationChannelId,
      this.notificationId);

  Future<void> initializeService() async {
    final service = FlutterBackgroundService();

    AndroidNotificationChannel channel = AndroidNotificationChannel(
      notificationChannelId,
      'MY FOREGROUND SERVICE',
      description: 'This channel is used for important notifications.',
      importance: Importance.low,
    );

    await notificationHandler.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await service.configure(
        androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          autoStart: true,
          isForegroundMode: true,
          notificationChannelId: notificationChannelId,
          initialNotificationTitle: 'AWESOME SERVICE',
          initialNotificationContent: 'Initializing',
          foregroundServiceNotificationId: notificationId,
        ),
        iosConfiguration: IosConfiguration());
  }

  Future<void> onStart(ServiceInstance service) async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      notificationHandler.flutterLocalNotificationsPlugin.show(
        notificationId,
        'COOL SERVICE',
        'Awesome ${DateTime.now()}',
        NotificationDetails(
          android: AndroidNotificationDetails(
            notificationChannelId,
            'MY FOREGROUND SERVICE',
            icon: 'ic_bg_service_small',
            ongoing: true,
          ),
        ),
      );
    });
  }
}
