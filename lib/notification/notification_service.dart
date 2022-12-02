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
      'OpticianApp Notifications',
      description: 'This channel is used for optician notifications.',
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
            isForegroundMode: false,
            notificationChannelId: notificationChannelId,
            initialNotificationTitle: 'OpticianApp Service',
            initialNotificationContent: 'Initializing'),
        iosConfiguration: IosConfiguration());
  }

  Future<void> onStart(ServiceInstance service) async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      notificationHandler.flutterLocalNotificationsPlugin.show(
        notificationId,
        'OpticianApp Service',
        'Notification Service',
        NotificationDetails(
          android: AndroidNotificationDetails(
            notificationChannelId,
            'OpticianApp Service',
            icon: 'ic_bg_service_small',
            ongoing: true,
          ),
        ),
      );
    });
  }
}
