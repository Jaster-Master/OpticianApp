import 'package:flutter/material.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/model/order.dart';

import 'order_item.dart';

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

    orders.sort((a, b) => b.due.compareTo(a.due));
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
                  child: NotificationListener<OverscrollIndicatorNotification>(
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
