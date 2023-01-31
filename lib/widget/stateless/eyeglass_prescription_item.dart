import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/model/eyeglass_prescription.dart';
import 'package:opticianapp/widget/stateless/eyegalss_prescription_details.dart';
import 'package:opticianapp/widget/stateless/eyeglass_prescription_item.dart';

class EyeglassPrescriptionItem extends StatelessWidget {
  EyeglassPrescription item;
  int index;

  EyeglassPrescriptionItem(this.item, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: DefaultProperties.morePadding),
      child: GestureDetector(
        onTap: () => {onItemPress(context, item)},
        child: Container(
          margin: EdgeInsets.all(DefaultProperties.defaultPadding),
          padding: EdgeInsets.all(DefaultProperties.defaultPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.circular(DefaultProperties.defaultRounded),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 10.0)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Brillenpass",
                  style: TextStyle(fontSize: DefaultProperties.fontSize2)),
              Text(
                  "vom " +
                      DefaultProperties.defaultDateFormat.format(item.date),
                  style: TextStyle(fontSize: DefaultProperties.fontSize3))
            ],
          ),
        ),
      ),
    );
  }

  void onItemPress(BuildContext context, EyeglassPrescription item) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EyeglassPrescriptionDetailsView(item)));
  }
}

