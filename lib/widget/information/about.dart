import 'package:flutter/material.dart';

import '../../default_properties.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
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
            Text("Über Optics", style:TextStyle(fontSize: DefaultProperties.fontSize1)),
            Column(children: [Text("TODO by Asabit")]),
          ],
        ),
      ),
    );
  }

  void onBackButtonPress(BuildContext context) {
    Navigator.pop(context);
  }
}
