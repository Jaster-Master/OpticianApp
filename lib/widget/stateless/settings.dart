import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/default_properties.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var tabText = Text("Einstellungen",
        style: TextStyle(fontSize: DefaultProperties.fontSize1));
    var tab = Row(
      children: [
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: DefaultProperties.blueColor,
                    width: 5,
                  ),
                ),
              ),
              child: tabText,
            ),
            IconButton(
              icon: Icon(Icons.local_shipping_outlined, size: 0),
              onPressed: null,
            ),
          ],
        ),
      ],
    );
    return Padding(
      padding: EdgeInsets.only(top: DefaultProperties.defaultPadding),
      child: Padding(
        padding: EdgeInsets.all(DefaultProperties.morePadding),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          tab,
        ]),
      ),
    );
  }
}

class FAQ extends StatelessWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Impressum extends StatelessWidget {
  const Impressum({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Feedback extends StatelessWidget {
  const Feedback({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
