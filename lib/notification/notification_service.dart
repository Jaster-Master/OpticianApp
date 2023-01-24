import 'dart:async';
import 'dart:convert';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:http/http.dart' as http;
import 'package:opticianapp/notification/notification_handler.dart';

import '../default_properties.dart';

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

  static Future<bool> onIosBackground(ServiceInstance service) async {
    checkDues();
    return true;
  }

  static Future<bool> onStart(ServiceInstance service) async {
    checkDues();
    return true;
  }

  static Future<void> checkDues() async {
    Timer.periodic(const Duration(hours: 1), (timer) {
      getAppointmentDues().then((value) {
        value?.forEach((element) {
          var title = element['type'].toString().endsWith("E")
              ? "Erinnerung"
              : "Termin";
          notificationHandler.showNotification(title, element['text']);
        });
      });
      getOrderDues().then((value) {
        value?.forEach((element) {
          notificationHandler.showNotification("Auftrag", element['text']);
        });
      });
    });
  }

  static Future<List<dynamic>?> getAppointmentDues() async {
    try {
      var client = http.Client();
      var response = await client.get(
          Uri.parse("${DefaultProperties.serverIpAddress}/appointment-dues"));
      if (response.statusCode.toString().startsWith('2')) {
        return jsonDecode(response.body) as List<dynamic>;
      }
    } catch (e) {
      return [];
    }
    return [];
  }

  static Future<List<dynamic>?> getOrderDues() async {
    try {
      var client = http.Client();
      var response = await client
          .get(Uri.parse("${DefaultProperties.serverIpAddress}/order-dues"));
      if (response.statusCode.toString().startsWith('2')) {
        return jsonDecode(response.body) as List<dynamic>;
      }
    } catch (e) {
      return [];
    }
    return [];
  }
}
