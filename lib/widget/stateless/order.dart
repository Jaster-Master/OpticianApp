import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/model/order.dart';

class OrderView extends StatelessWidget {
  List<Order> orders;
  PageController controller;

  OrderView(this.orders, this.controller);

  @override
  Widget build(BuildContext context) {
    var tabText = Text("Auftragsverfolgung",
        style: TextStyle(fontSize: DefaultProperties.fontSize1));
    var tabs = Row(
      children: [
        IconButton(
            tooltip: "Termine",
            color: DefaultProperties.grayColor,
            onPressed: () => onAppointmentsPress(),
            icon: Icon(Icons.calendar_today_outlined,
                size: DefaultProperties.buttonSize)),
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
              tooltip: "Aufträge",
              icon: Icon(Icons.local_shipping_outlined,
                  size: DefaultProperties.buttonSize),
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

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(DefaultProperties.morePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            tabs,
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(5),
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
                  child:
                      NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: index == orders.length - 1
                                  ? DefaultProperties.doubleMorePadding
                                  : 0),
                          child: OrderItem(orders[index]),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            pageDots,
          ],
        ),
      ),
    );
  }

  void onAppointmentsPress() {
    controller.jumpToPage(0);
  }
}

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
