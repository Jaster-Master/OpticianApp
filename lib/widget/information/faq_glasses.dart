import 'package:flutter/material.dart';

import '../../default_properties.dart';

class FaqGlassesView extends StatelessWidget {
  List<String> questions = [
    "How to find Gobl?",
    "What is the difference between an appointment and reminder?"
  ];
  List<String> answers = [
    "It is impossible to find him!",
    "An appointment is set by the optician and a reminder is set by you."
  ];

  FaqGlassesView({super.key});

  @override
  Widget build(BuildContext context) {
    var questionWidgets = <Widget>[];
    for (int i = 0; i < questions.length; i++) {
      questionWidgets.add(ExpansionTile(
        title: Text(questions[i]),
        children: [Text(answers[i])],
      ));
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => {onBackButtonPress(context)},
                    icon: Icon(Icons.arrow_back)),
                Text("Zurück",
                    style: TextStyle(fontSize: DefaultProperties.fontSize2)),
              ],
            ),
            Text("FAQ Brillen"),
            Column(children: questionWidgets),
          ],
        ),
      ),
    );
  }

  void onBackButtonPress(BuildContext context) {
    Navigator.pop(context);
  }
}
