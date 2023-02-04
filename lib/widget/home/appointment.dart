import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opticianapp/data/json_writer.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/model/appointment.dart';
import 'package:opticianapp/widget/home/appointment.dart';

import 'appointment_item.dart';

class AppointmentView extends StatefulWidget {
  List<Appointment> appointments;
  PageController controller;

  AppointmentView(this.appointments, this.controller, {super.key});

  @override
  State<StatefulWidget> createState() => AppointmentViewState();
}

class AppointmentViewState extends State<AppointmentView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var tabText = Text("Meine Termine",
        style: TextStyle(fontSize: DefaultProperties.fontSize1));
    var headerText = Text("${widget.appointments.length} Termine",
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
              onPressed: () => onOrdersPress(),
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
            onPressed: () => {onAddReminder()},
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

    widget.appointments.sort((a, b) => b.due.compareTo(a.due));
    return SafeArea(
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
                    itemCount: widget.appointments.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: index == widget.appointments.length - 1
                                ? DefaultProperties.doubleMorePadding
                                : 0),
                        child: AppointmentItem(this, widget.appointments,
                            widget.appointments[index]),
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

  void onOrdersPress() {
    widget.controller.jumpToPage(1);
  }

  void onAddReminder() {
    TextEditingController date = TextEditingController();
    String title = "";
    date.text = DefaultProperties.defaultDateFormat.format(DateTime.now());
    var currentState = this;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Erinnerung erstellen'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Titel',
                          icon: Icon(Icons.title),
                          errorMaxLines: 3,
                          errorStyle: TextStyle(color: Colors.red)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Bitte geben Sie einen Namen ein!";
                        }
                        return null;
                      },
                      onChanged: (value) => title = value,
                    ),
                    TextFormField(
                      controller: date,
                      decoration: const InputDecoration(
                          labelText: 'Datum',
                          icon: Icon(Icons.calendar_today),
                          errorMaxLines: 3,
                          errorStyle: TextStyle(color: Colors.red)),
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Bitte geben Sie ein Datum ein!";
                        }
                        return null;
                      },
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
                    Row(
                      children: [],
                    )
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
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    createReminder(title, date.text).then((value) => {
                          currentState.setState(() {
                            widget.appointments.add(new Appointment(
                                value?['id'],
                                value?['customerID'],
                                value?['type'],
                                value?['text'] ?? "",
                                DateTime.parse(value?['due']),
                                DateTime.parse(value?['timestamp'])));
                          })
                        });

                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  static Future<Map<String, dynamic>?> createReminder(
      String text, String due) async {
    due = DateFormat("yyyy-MM-dd").format(DateFormat("dd.MM.yyyy").parse(due));
    Map<String, dynamic> jsonMap = {'text': text, 'due': due};

    try {
      Map<String, dynamic> responseJson =
          await JsonWriter.createReminderHttps(jsonMap);
      return responseJson;
    } catch (e) {
      print('Failed to send JSON data: $e');
    }
  }
}


