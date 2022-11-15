import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/model/appointment.dart';
import 'package:opticianapp/widget/stateful/appointment.dart';

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
    var headerText = Text("10 Termine",
        style: TextStyle(
            fontSize: DefaultProperties.fontSize1,
            color: DefaultProperties.grayColor));
    var tabs = Padding(
      padding: EdgeInsets.only(bottom: DefaultProperties.morePadding),
      child: Row(
        children: [
          Row(
            children: [
              IconButton(
                tooltip: "Termine",
                icon: Icon(
                  Icons.calendar_today_outlined,
                  size: DefaultProperties.buttonSize,
                ),
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
            tooltip: "Aufträge",
              color: DefaultProperties.grayColor,
              onPressed: () => onPress(),
              icon: Icon(
                Icons.local_shipping_outlined,
                size: DefaultProperties.buttonSize,
              )),
        ],
      ),
    );
    var addButton = Row(
      children: [
        CircleAvatar(
          backgroundColor: DefaultProperties.blueColor,
          radius: DefaultProperties.buttonSize / 1.2,
          child: IconButton(
            tooltip: "Erinnerung hinzufügen",
            padding: EdgeInsets.zero,
            onPressed: () => {onAddAppointment()},
            icon: Icon(
              Icons.add,
              size: DefaultProperties.buttonSize,
            ),
            color: Colors.white,
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: DefaultProperties.defaultPadding),
          child: headerText,
        )
      ],
    );
    var pageDots = Padding(
      padding: EdgeInsets.only(top: DefaultProperties.morePadding),
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
      padding: EdgeInsets.only(top: DefaultProperties.defaultPadding),
      child: Padding(
        padding: EdgeInsets.all(DefaultProperties.morePadding),
        child: Column(
          children: [
            tabs,
            addButton,
            Expanded(
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
                    padding: EdgeInsets.all(0),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      // extra padding for last item with hardcoded index TODO
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: index == 9
                                ? DefaultProperties.moreMorePadding
                                : 0),
                        child: AppointmentItem(Appointment(
                            0,
                            0,
                            "TE",
                            "Sehschärfenkontrolleadsfsadfasdfsadf",
                            DateTime.now(),
                            DateTime.now())),
                      );
                    },
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

  void onPress() {
    widget.updateView(false);
  }

  void onAddAppointment() {
    TextEditingController date = TextEditingController();
    date.text = DefaultProperties.defaultDateFormat.format(DateTime.now());
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Erinnerung erstellen'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Titel',
                        icon: Icon(Icons.title),
                      ),
                    ),
                    TextField(
                      controller: date,
                      decoration: InputDecoration(
                        labelText: 'Datum',
                        icon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          String formattedDate = DefaultProperties
                              .defaultDateFormat
                              .format(pickedDate);
                          setState(() {
                            date.text = formattedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  child: Text("Abbrechen"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text("Erstellen"),
                  onPressed: () {
                    setState(() {
                      // TODO create
                    });

                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }
}

class AppointmentItem extends StatefulWidget {
  Appointment item;

  AppointmentItem(this.item, {super.key});

  @override
  State<StatefulWidget> createState() => AppointmentItemState();
}

class AppointmentItemState extends State<AppointmentItem> {
  @override
  Widget build(BuildContext context) {
    int days = widget.item.due.difference(DateTime.now()).inDays;
    if (days < 0) days = 0;
    double height = 150;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    var timeline = Container(
      margin: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: DefaultProperties.grayColor)),
      ),
      child: SizedBox(height: height),
    );
    var timelineDot = Container(
      margin: EdgeInsets.only(left: 15),
      child: Icon(
        Icons.circle,
        color: DefaultProperties.blueColor,
        size: DefaultProperties.iconSize,
      ),
    );
    var descriptionText = Expanded(
        child: Text(widget.item.text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(fontSize: DefaultProperties.fontSize2)));
    var dateText = Padding(
      padding: EdgeInsets.only(bottom: DefaultProperties.defaultPadding),
      child: Row(
        children: [
          Text(DefaultProperties.defaultDateFormat.format(widget.item.due),
              style: TextStyle(fontSize: DefaultProperties.fontSize1)),
        ],
      ),
    );
    var leftDaysText = Row(
      children: [
        Text("noch $days Tage",
            style: TextStyle(
                fontSize: DefaultProperties.fontSize3,
                color: DefaultProperties.grayColor)),
      ],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [timeline, timelineDot],
        ),
        Expanded(
          child: SizedBox(
            height: height,
            child: Padding(
              padding:
                  EdgeInsets.only(bottom: DefaultProperties.defaultPadding),
              child: GestureDetector(
                onTap: () => {onItemPress(context, widget)},
                child: Container(
                  margin: EdgeInsets.only(
                      left: isLandscape
                          ? DefaultProperties.moreMorePadding
                          : DefaultProperties.defaultPadding),
                  child: Container(
                    margin: EdgeInsets.all(DefaultProperties.defaultPadding),
                    padding: EdgeInsets.all(DefaultProperties.defaultPadding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                          DefaultProperties.defaultRounded),
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
                            descriptionText,
                            Visibility(
                              visible: widget.item.type == "TE",
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              child: PopupMenuButton(
                                tooltip: "Menü anzeigen",
                                constraints: BoxConstraints(),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: DefaultProperties.defaultPadding),
                                  child: Icon(Icons.menu,
                                      size: DefaultProperties.buttonSize),
                                ),
                                onSelected: (value) =>
                                    {onMenuPress(context, value, widget)},
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry>[
                                  const PopupMenuItem(
                                    value: 0,
                                    child: Text('Bearbeiten'),
                                  ),
                                  const PopupMenuItem(
                                    value: 1,
                                    child: Text('Löschen'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        dateText,
                        leftDaysText,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onItemPress(BuildContext context, AppointmentItem item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
              item.item.type == "TE" ? "Erinnerung" : "Termin",
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

  void onMenuPress(BuildContext context, value, AppointmentItem item) {
    TextEditingController date = TextEditingController();
    date.text = DefaultProperties.defaultDateFormat.format(item.item.due);
    if (value == 1) {
      // TODO remove
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Erinnerung bearbeiten'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Titel',
                        icon: Icon(Icons.title),
                      ),
                      controller: TextEditingController(text: item.item.text),
                    ),
                    TextField(
                      controller: date,
                      decoration: InputDecoration(
                        labelText: 'Datum',
                        icon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          String formattedDate = DefaultProperties
                              .defaultDateFormat
                              .format(pickedDate);
                          setState(() {
                            date.text = formattedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  child: Text("Abbrechen"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text("Bearbeiten"),
                  onPressed: () {
                    setState(() {
                      // TODO edit
                    });

                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }
}
