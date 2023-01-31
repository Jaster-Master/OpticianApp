import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/model/eyeglass_prescription.dart';
import 'package:opticianapp/widget/stateless/eyeglass_prescription.dart';
import 'package:opticianapp/widget/stateless/eyeglass_prescription_item.dart';

class EyeglassPrescriptionView extends StatefulWidget {
  List<EyeglassPrescription> eyeglassPrescriptions;

  EyeglassPrescriptionView(this.eyeglassPrescriptions, {super.key});

  @override
  State<StatefulWidget> createState() => EyeglassPrescriptionViewState();
}

class EyeglassPrescriptionViewState extends State<EyeglassPrescriptionView> {
  int index = -1;

  @override
  Widget build(BuildContext context) {
    var tabText = Text("Brillenpass",
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

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(DefaultProperties.morePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            tab,
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(DefaultProperties.lessPadding),
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.white.withOpacity(0.05)],
                      stops: [0.75, 1],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds);
                  },
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: ListView.builder(
                      itemCount: widget.eyeglassPrescriptions.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: index ==
                                      widget.eyeglassPrescriptions.length - 1
                                  ? DefaultProperties.doubleMorePadding
                                  : 0),
                          child: EyeglassPrescriptionItem(
                              widget.eyeglassPrescriptions[index], index),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
