import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:opticianapp/model/appointment.dart';
import 'package:opticianapp/model/eyeglass_prescription.dart';
import 'package:opticianapp/model/order.dart';

class JsonReader {
  static List<dynamic>? jsonData;
  static List<Appointment> appointments = [];
  static List<Order> orders = [];
  static List<EyeglassPrescription> eyeglassPrescriptions = [];

  static Future<bool> initData() async {
    jsonData = await readJsonFile("assets/data.json");
    if (jsonData != null) {
      readJsonData();
      return true;
    }
    return false;
  }

  static void readJsonData() {
    int length = jsonData?.length ?? 0;
    for (int i = 0; i < length; i++) {
      Map<String, dynamic>? json = jsonData?.elementAt(i);
      if (json == null) continue;
      // Pass, Auftrag, Termin
      if (json["type"][0] == "P") {
        eyeglassPrescriptions.add(EyeglassPrescription.fromJson(json));
      } else if (json["type"][0] == "A") {
        orders.add(Order.fromJson(json));
      } else if (json["type"][0] == "T") {
        appointments.add(Appointment.fromJson(json));
      }
    }
  }

  static Future<List<dynamic>> readJsonFile(String filePath) async {
    final String response = await rootBundle.loadString(filePath);
    return await jsonDecode(response);
  }
}
