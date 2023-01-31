import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:opticianapp/model/appointment.dart';
import 'package:opticianapp/model/eyeglass_prescription.dart';
import 'package:opticianapp/model/optician.dart';
import 'package:opticianapp/model/order.dart';

import '../default_properties.dart';

class JsonReader {
  static List<dynamic> jsonEyeglassPrescriptions = [];
  static List<dynamic> jsonAppointments = [];
  static List<dynamic> jsonOrders = [];
  static List<dynamic> jsonOpticians = [];
  static List<Appointment> appointments = [];
  static List<Order> orders = [];
  static List<EyeglassPrescription> eyeglassPrescriptions = [];
  static List<Optician> opticians = [];

  static Future<bool> initData() async {
    resetData();
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.parse(
              "${DefaultProperties.serverIpAddress}/eyeglass-prescriptions"))
          .timeout(const Duration(seconds: 4));
      if (response.statusCode.toString().startsWith('2')) {
        jsonEyeglassPrescriptions = jsonDecode(response.body) as List<dynamic>;
      }
      response = await client
          .get(Uri.parse("${DefaultProperties.serverIpAddress}/appointments"))
          .timeout(const Duration(seconds: 4));
      if (response.statusCode.toString().startsWith('2')) {
        jsonAppointments = jsonDecode(response.body) as List<dynamic>;
      }
      response = await client
          .get(Uri.parse("${DefaultProperties.serverIpAddress}/orders"))
          .timeout(const Duration(seconds: 4));
      if (response.statusCode.toString().startsWith('2')) {
        jsonOrders = jsonDecode(response.body) as List<dynamic>;
      }
      response = await client
          .get(Uri.parse("${DefaultProperties.serverIpAddress}/opticians"))
          .timeout(const Duration(seconds: 4));
      if (response.statusCode.toString().startsWith('2')) {
        jsonOpticians = jsonDecode(response.body) as List<dynamic>;
      }
    } catch (e) {
      return false;
    }
    if (jsonEyeglassPrescriptions != null &&
        jsonAppointments != null &&
        jsonOrders != null && jsonOpticians != null) {
      readEyeglassPrescriptions();
      readAppointments();
      readOrders();
      readOpticians();
      return true;
    }
    return false;
  }

  static void readEyeglassPrescriptions() {
    jsonEyeglassPrescriptions.forEach((element) {
      if (element == null) return;
      // Pass, Auftrag, Termin
      if (element["type"][0] == "P") {
        eyeglassPrescriptions.add(EyeglassPrescription.fromJson(element));
      }
    });
  }

  static void readOrders() {
    jsonOrders.forEach((element) {
      if (element == null) return;
      // Pass, Auftrag, Termin
      if (element["type"][0] == "A") {
        orders.add(Order.fromJson(element));
      }
    });
  }

  static void readAppointments() {
    jsonAppointments.forEach((element) {
      if (element == null) return;
      // Pass, Auftrag, Termin
      if (element["type"][0] == "T") {
        appointments.add(Appointment.fromJson(element));
      }
    });
  }

  static void readOpticians() {
    jsonOpticians.forEach((element) {
      if (element == null) return;
      opticians.add(Optician.fromJson(element));
    });
  }

  static void resetData() {
    jsonEyeglassPrescriptions.clear();
    jsonAppointments.clear();
    jsonOrders.clear();
    eyeglassPrescriptions.clear();
    appointments.clear();
    orders.clear();
  }
}
