import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/default_properties.dart';

class OrderView extends StatelessWidget {
  ValueChanged<bool> updateView;

  OrderView(this.updateView);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DefaultProperties.morePadding),
      child: Column(
        children: [
          Row(
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
                    child: const Text(
                      "Auftragsverfolgung",
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.local_shipping_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Scaffold(body: ListView()),
          )
        ],
      ),
    );
  }

  void onPress() {
    updateView(true);
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("among2");
  }
}
