import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:opticianapp/model/eyeglass_prescription.dart';

class JsonReader {
  static Future<EyeglassPrescription?> getJson() async {
    var json = await readJsonFile("assets/data.json");
    print(json.elementAt(0));
    return null;
  }

  static Future<List<dynamic>> readJsonFile(String filePath) async {
    final String response = await rootBundle.loadString(filePath);
    final data = await json.decode(response);
    return data;
  }
}
