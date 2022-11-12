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
    var tabText = Text("Meine Termine",
        style: TextStyle(fontSize: DefaultProperties.fontSize1));
    var headerText = Text("Anzahl Termine",
        style: TextStyle(fontSize: DefaultProperties.fontSize1));
    var tabs = Row(
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
              child: tabText,
            ),
          ],
        ),
        Spacer(),
        IconButton(
            onPressed: () => onPress(),
            icon: Icon(Icons.local_shipping_outlined)),
      ],
    );
    var addButton = Row(
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
          child: headerText,
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
            child: Icon(Icons.circle,
                size: 10, color: DefaultProperties.blueColor),
          ),
          Icon(Icons.circle_outlined,
              size: 10, color: DefaultProperties.blueColor)
        ],
      ),
    );

    return Padding(
      padding: EdgeInsets.all(DefaultProperties.morePadding),
      child: Column(
        children: [
          tabs,
          addButton,
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
          pageDots,
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
    int days = item.due.difference(DateTime.now()).inDays;
    if (days < 0) days = 0;
    double height = 140;

    var timeline = Container(
      padding: EdgeInsets.only(left: 40),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: DefaultProperties.blueColor)),
      ),
      child: SizedBox(height: height),
    );
    var timelineDot = Padding(
      padding:
          EdgeInsets.only(right: 40, bottom: DefaultProperties.morePadding),
      child: Icon(
        Icons.circle,
        color: DefaultProperties.blueColor,
      ),
    );
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

    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [timeline, timelineDot],
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
                        descriptionText,
                        IconButton(
                            padding: EdgeInsets.all(0),
                            icon: Icon(Icons.menu),
                            onPressed: () => {})
                      ],
                    ),
                    dateText,
                    leftDaysText,
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
