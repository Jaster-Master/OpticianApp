import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/model/eyeglass_prescription.dart';

class EyeglassPrescriptionView extends StatelessWidget {
  EyeglassPrescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    var tabText = Text("Brillenpass",
        style: TextStyle(fontSize: DefaultProperties.fontSize1));

    return Padding(
        padding: EdgeInsets.all(DefaultProperties.morePadding),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: DefaultProperties.morePadding),
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
              ],
            ),
            SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("eyeglassPrescription.text"),
                    ExpansionTile(
                      title: Text("Personal"),
                      children: [
                        Text("eyeglassPrescription.forename"),
                        Text("eyeglassPrescription.surname")
                      ],
                    ),
                    ExpansionTile(
                      title: Text("Eyes"),
                      children: [
                        Text("eyeglassPrescription.forename"),
                        Text("eyeglassPrescription.surname")
                      ],
                    ),
                    ExpansionTile(
                      title: Text("Glasses"),
                      children: [
                        Text("eyeglassPrescription.forename"),
                        Text("eyeglassPrescription.surname")
                      ],
                    ),
                  ],
                )),
          ],
        ));
  }
}
