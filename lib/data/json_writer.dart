import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:opticianapp/default_properties.dart';

class JsonWriter {
  static Future<Map<String, dynamic>> createReminderHttps(
      Map<String, dynamic> jsonMap) async {
    // Encode jsonMap as a JSON string
    var jsonString = json.encode(jsonMap);

    // Create a new HTTP client
    var client = http.Client();

    try {
      // Send a POST request to the server with the JSON payload
      var response = await client.post(
          Uri.https(DefaultProperties.serverIpAddress),
          body: jsonString,
          headers: {'Content-Type': 'application/json'});

      // Check that the server returned a 200 OK status code
      if (!response.statusCode.toString().startsWith("2")) {
        throw Exception('Failed to send JSON data');
      }

      // Decode the response JSON
      Map<String, dynamic> responseJson = json.decode(response.body);
      return responseJson;
    } finally {
      // Close the HTTP client
      client.close();
    }
  }

  static Future<bool> removeReminder(int id) async {
    // Create a new HTTP client
    var client = http.Client();

    try {
      // Send a POST request to the server with the JSON payload
      var response = await client.post(
          Uri.https(DefaultProperties.serverIpAddress),
          body: id,
          headers: {'Content-Type': 'application/json'});

      // Check that the server returned a 200 OK status code
      if (!response.statusCode.toString().startsWith("2")) {
        throw Exception('Failed to send JSON data');
      }
      return true;
    } finally {
      // Close the HTTP client
      client.close();
    }
  }
}
