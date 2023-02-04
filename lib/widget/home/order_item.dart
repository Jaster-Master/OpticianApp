import 'package:flutter/material.dart';

import '../../../default_properties.dart';
import '../../../model/order.dart';

class OrderItem extends StatelessWidget {
  Order item;

  OrderItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    int days = item.due.difference(DateTime.now()).inDays;
    if (days < 0) days = 0;
    Color color = item.finished ? Colors.green : Colors.red;

    var descriptionText = Expanded(
        child: Text(item.text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(fontSize: DefaultProperties.fontSize2)));
    var dateText = Padding(
      padding: EdgeInsets.only(bottom: DefaultProperties.defaultPadding),
      child: Text(DefaultProperties.defaultDateFormat.format(item.due),
          style: TextStyle(fontSize: DefaultProperties.fontSize1)),
    );
    var leftDaysText = Text("noch $days Tage",
        style: TextStyle(
            fontSize: DefaultProperties.fontSize3,
            color: DefaultProperties.grayColor));

    return Padding(
      padding: EdgeInsets.only(bottom: DefaultProperties.morePadding),
      child: GestureDetector(
        onTap: () => {onItemPress(context, this)},
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
              Row(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(right: DefaultProperties.lessPadding),
                    child: Icon(
                      Icons.circle,
                      color: color,
                      size: DefaultProperties.iconSize,
                    ),
                  ),
                  descriptionText,
                ],
              ),
              dateText,
              leftDaysText,
            ],
          ),
        ),
      ),
    );
  }

  void onItemPress(BuildContext context, OrderItem item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              "Bestellung",
              textAlign: TextAlign.center,
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.title),
                    Text(
                      item.item.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: DefaultProperties.fontSize3),
                    ),
                    Text(""),
                    Icon(Icons.calendar_today),
                    Text(
                      DefaultProperties.defaultDateFormat.format(item.item.due),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: DefaultProperties.fontSize3),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }
}
