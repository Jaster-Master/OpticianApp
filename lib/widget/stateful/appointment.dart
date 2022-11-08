import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/default_properties.dart';

class AppointmentView extends StatefulWidget {
  ValueChanged<bool> updateView;

  AppointmentView(this.updateView);

  @override
  State<StatefulWidget> createState() => AppointmentViewState();
}

class AppointmentViewState extends State<AppointmentView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DefaultProperties.morePadding),
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.calendar_today_outlined),
                    onPressed: () {},
                  ),
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
                      "Meine Termine",
                    ),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: () => onPress(),
                  icon: Icon(Icons.local_shipping_outlined)),
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
    widget.updateView(false);
  }
}

class AppointmentItem extends StatelessWidget {
  const AppointmentItem({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class AppointmentItemDetails extends StatelessWidget {
  const AppointmentItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
