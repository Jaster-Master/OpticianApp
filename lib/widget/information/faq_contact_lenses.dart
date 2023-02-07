import 'package:flutter/material.dart';

import '../../default_properties.dart';

class FaqContactLensesView extends StatelessWidget {
  List<String> questions = ["Question-Placeholder", "Answer-Placeholder"];
  List<String> answers = ["Question-Placeholder", "Answer-Placeholder"];

  FaqContactLensesView({super.key});

  @override
  Widget build(BuildContext context) {
    var questionWidgets = <Widget>[];
    for (int i = 0; i < questions.length; i++) {
      questionWidgets.add(ExpansionTile(
        title: Text(questions[i]),
        children: [
          Padding(
            padding: const EdgeInsets.all(DefaultProperties.defaultPadding),
            child: Text(answers[i]),
          )
        ],
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
            Text("FAQ Kontaktlinsen",
                style: TextStyle(fontSize: DefaultProperties.fontSize1)),
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
