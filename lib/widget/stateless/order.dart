import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/model/order.dart';

class OrderView extends StatelessWidget {
  ValueChanged<bool> updateView;

  OrderView(this.updateView);

  @override
  Widget build(BuildContext context) {
    var tabText = Text("Auftragsverfolgung",
        style: TextStyle(fontSize: DefaultProperties.fontSize1));
    var tabs = Row(
      children: [
        IconButton(
            onPressed: () => onPress(),
            icon: Icon(Icons.calendar_today_outlined)),
        Spacer(),
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
              icon: Icon(Icons.local_shipping_outlined),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
    var pageDots = Padding(
      padding: EdgeInsets.only(top: DefaultProperties.defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: DefaultProperties.defaultPadding),
            child: Icon(Icons.circle_outlined,
                size: 10, color: DefaultProperties.blueColor),
          ),
          Icon(Icons.circle, size: 10, color: DefaultProperties.blueColor)
        ],
      ),
    );

    return Padding(
      padding: EdgeInsets.all(DefaultProperties.morePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          tabs,
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return OrderItem(Order(0, 0, "", "Sport Brille 25x Ultra",
                      DateTime.now(), false, DateTime.now()));
                },
              ),
            ),
          ),
          pageDots,
        ],
      ),
    );
  }

  void onPress() {
    updateView(true);
  }
}

class OrderItem extends StatelessWidget {
  Order item;

  OrderItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    int days = 0;
    Color color = item.finished ? Colors.green : Colors.red;
    var descriptionText = Text(item.text,
        style: TextStyle(fontSize: DefaultProperties.fontSize1));
    var dateText = Row(
      children: [
        Text(DateFormat("dd.MM.yyyy").format(item.due),
            style: TextStyle(fontSize: DefaultProperties.fontSize1)),
      ],
    );
    var leftDaysText = Row(
      children: [
        Text("noch $days Tage",
            style: TextStyle(fontSize: DefaultProperties.fontSize1)),
      ],
    );

    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: DefaultProperties.morePadding),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: DefaultProperties.blueColor),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle, color: color),
                      descriptionText,
                      IconButton(
                          icon: Icon(Icons.menu),
                          padding: EdgeInsets.all(0),
                          onPressed: () => {})
                    ],
                  ),
                  dateText,
                  leftDaysText,
                ],
              ),
            ),
          ),
        ],
      );
  }
}
