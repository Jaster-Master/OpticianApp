import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/model/appointment.dart';

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
                    child: const Text("Meine Termine",
                        style:
                            TextStyle(fontSize: DefaultProperties.fontSize1)),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: () => onPress(),
                  icon: Icon(Icons.local_shipping_outlined)),
            ],
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: DefaultProperties.blueColor,
                child: IconButton(
                  onPressed: () => {},
                  icon: Icon(Icons.add),
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Anzahl Termine",
                    style: TextStyle(fontSize: DefaultProperties.fontSize1)),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: 10,
              itemBuilder: (context, index) {
                return AppointmentItem(Appointment(0, 0, "",
                    "Sehschärfenkontrolle", DateTime.now(), DateTime.now()));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: DefaultProperties.defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(right: DefaultProperties.defaultPadding),
                  child: Icon(Icons.circle,
                      size: 10, color: DefaultProperties.blueColor),
                ),
                Icon(Icons.circle_outlined,
                    size: 10, color: DefaultProperties.blueColor)
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onPress() {
    widget.updateView(false);
  }
}

class AppointmentItem extends StatelessWidget {
  Appointment item;

  AppointmentItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    int days = 0;
    double height = 140;
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 40),
                decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(color: DefaultProperties.blueColor)),
                ),
                child: SizedBox(height: height),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: 40, bottom: DefaultProperties.morePadding),
                child: Icon(
                  Icons.circle,
                  color: DefaultProperties.blueColor,
                ),
              ),
            ],
          ),
          Spacer(),
          SizedBox(
            height: height,
            child: Padding(
              padding: EdgeInsets.only(bottom: DefaultProperties.morePadding),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: DefaultProperties.blueColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(item.text,
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize1)),
                        IconButton(
                            padding: EdgeInsets.all(0),
                            icon: Icon(Icons.menu),
                            onPressed: () => {})
                      ],
                    ),
                    Row(
                      children: [
                        Text(DateFormat("dd.MM.yyyy").format(item.due),
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize1)),
                      ],
                    ),
                    Row(
                      children: [
                        Text("noch $days Tage",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize1)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentItemEdit extends StatelessWidget {
  const AppointmentItemEdit({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
