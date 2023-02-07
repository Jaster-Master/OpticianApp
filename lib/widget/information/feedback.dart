import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../default_properties.dart';

class FeedbackView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FeedbackViewState();
}

class FeedbackViewState extends State<FeedbackView> {
  final _formKey = GlobalKey<FormState>();
  String? feedbackText;
  String? errorText = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () => {onBackButtonPress(context)},
                        icon: Icon(Icons.arrow_back)),
                    Text("Zurück",
                        style:
                            TextStyle(fontSize: DefaultProperties.fontSize2)),
                  ],
                ),
                Text("Feedback",
                    style: TextStyle(fontSize: DefaultProperties.fontSize1)),
                Column(children: [
                  Padding(
                    padding:
                        const EdgeInsets.all(DefaultProperties.defaultPadding),
                    child: TextFormField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                DefaultProperties.defaultRounded),
                          ),
                          labelText: 'Feedback eingeben',
                          errorMaxLines: 3,
                          errorStyle: TextStyle(color: Colors.red)),
                      onChanged: (value) {
                        feedbackText = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Bitte geben Sie einen Text ein!";
                        }
                        return null;
                      },
                    ),
                  ),
                  Visibility(
                    visible: errorText != null,
                    child: Padding(
                      padding: const EdgeInsets.all(
                          DefaultProperties.defaultPadding),
                      child: Text(errorText ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: DefaultProperties.fontSize3,
                              color: Colors.red)),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.all(DefaultProperties.defaultPadding),
                    child: SizedBox(
                      height: 75,
                      width: 300,
                      child: OutlinedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      DefaultProperties.defaultRounded))),
                        ),
                        child: Text("Senden",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize1)),
                        onPressed: () => {onSendFeedback(feedbackText ?? "")},
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onSendFeedback(String feedback) async {
    if (!_formKey.currentState!.validate()) return;
    var jsonString = jsonEncode(feedback);

    var client = http.Client();

    try {
      var response = await client.post(
          Uri.parse("${DefaultProperties.serverIpAddress}/feedback"),
          body: jsonString,
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode.toString().startsWith("2")) {
        setState(() {
          errorText = null;
        });
      }
      setState(() {
        errorText =
            "Es ist ein Fehler bei der Verbindung zum Server aufgetreten!";
      });
    } catch (_) {
      setState(() {
        errorText =
            "Es ist ein Fehler bei der Verbindung zum Server aufgetreten!";
      });
    } finally {
      client.close();
    }
  }

  void onBackButtonPress(BuildContext context) {
    Navigator.pop(context);
  }
}
