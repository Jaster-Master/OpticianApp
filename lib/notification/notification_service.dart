import 'dart:async';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:http/http.dart';
import 'package:opticianapp/notification/notification_handler.dart';

class NotificationService {
  static NotificationHandler notificationHandler = NotificationHandler();

  Future<void> initializeService() async {
    notificationHandler.init();
    final service = FlutterBackgroundService();

    var androidConf = AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: false,
        autoStart: true,
        autoStartOnBoot: true);
    var iosConf = IosConfiguration(
        onForeground: onStart, onBackground: onIosBackground, autoStart: true);
    service.configure(
        iosConfiguration: iosConf, androidConfiguration: androidConf);
    bool isRunning = await service.isRunning();
    if (!isRunning) {
      service.startService();
    }
  }

  Future<bool> onIosBackground(ServiceInstance service) async {
    return true;
  }

  static Future<void> onStart(ServiceInstance service) async {
    final Client client = Client();
    while(true){
      // TODO: get response from server to display notification
    }
  }
}
