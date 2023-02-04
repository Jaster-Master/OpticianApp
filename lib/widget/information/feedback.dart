import 'package:flutter/material.dart';

import '../../default_properties.dart';

class FeedbackView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FeedbackViewState();
}

class FeedbackViewState extends State<FeedbackView> {
  final _formKey = GlobalKey<FormState>();
  String? feedbackText;

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
                Text("Feedback"),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(
                        DefaultProperties.defaultPadding),
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
                  Padding(
                    padding: const EdgeInsets.all(
                        DefaultProperties.defaultPadding),
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
                        onPressed: () => {onSendFeedback()},
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

  void onSendFeedback() {}

  void onBackButtonPress(BuildContext context) {
    Navigator.pop(context);
  }
}
