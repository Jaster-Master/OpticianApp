import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/json_writer.dart';
import '../../../default_properties.dart';
import '../../../model/appointment.dart';
import '../../../model/optician.dart';
import 'appointment.dart';

class AppointmentItem extends StatefulWidget {
  AppointmentViewState parentState;
  List<Appointment> appointments;
  Appointment item;

  AppointmentItem(this.parentState, this.appointments, this.item, {super.key});

  @override
  State<StatefulWidget> createState() => AppointmentItemState();
}

class AppointmentItemState extends State<AppointmentItem> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int days = widget.item.due.difference(DateTime.now()).inDays;
    if (days < 0) days = 0;
    double lineHeight = MediaQuery.of(context).size.height / 5;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    var timeline = Container(
      margin: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: DefaultProperties.grayColor)),
      ),
      child: SizedBox(height: lineHeight),
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
          child: Padding(
            padding: EdgeInsets.only(bottom: DefaultProperties.defaultPadding),
            child: GestureDetector(
              onTap: () => {onItemPress(context, widget)},
              child: Container(
                margin: EdgeInsets.only(
                    left: isLandscape
                        ? DefaultProperties.doubleMorePadding
                        : DefaultProperties.defaultPadding),
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
                                  child: Text(
                                    'Bearbeiten',
                                  ),
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
    if (value == 1) {
      deleteReminder(item);
      return;
    }
    editReminder(item);
  }

  void deleteReminder(AppointmentItem item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Erinnerung löschen', textAlign: TextAlign.center),
            content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Wollen Sie diese Erinnerung wirklich löschen?",
                  textAlign: TextAlign.center,
                )),
            actions: [
              TextButton(
                  child: Text("Nein"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text("Ja"),
                  onPressed: () {
                    JsonWriter.deleteReminder(item.item.id).then((value) => {
                      if (value)
                        {
                          widget.parentState.setState(() {
                            widget.appointments.removeWhere(
                                    (element) => element.id == item.item.id);
                          })
                        }
                    });

                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  void editReminder(AppointmentItem item) {
    TextEditingController date = TextEditingController();
    date.text = DefaultProperties.defaultDateFormat.format(item.item.due);
    int id = item.item.id;
    String text = item.item.text;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Erinnerung bearbeiten', textAlign: TextAlign.center),
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
                      controller: TextEditingController(text: item.item.text),
                      onChanged: (value) => {text = value},
                    ),
                    TextFormField(
                      controller: date,
                      decoration: InputDecoration(
                          labelText: 'Datum',
                          icon: Icon(Icons.calendar_today),
                          errorMaxLines: 3,
                          errorStyle: TextStyle(color: Colors.red)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Bitte geben Sie einen Namen ein!";
                        }
                        return null;
                      },
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
                    if (!_formKey.currentState!.validate()) return;

                    editReminderJson(id, text, date.text).then((value) => {
                      widget.parentState.setState(() {
                        var appointment = widget.appointments.singleWhere(
                                (element) => element.id == value?['id']);
                        appointment.text = value?['text'];
                        appointment.due = DateTime.parse(value?['due']);
                      })
                    });
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  Future<Map<String, dynamic>?> editReminderJson(
      int id, String text, String due) async {
    due = DateFormat("yyyy-MM-dd").format(DateFormat("dd.MM.yyyy").parse(due));
    Map<String, dynamic> jsonMap = {'ID': id, 'text': text, 'due': due};

    try {
      Map<String, dynamic> responseJson =
      await JsonWriter.editReminderHttps(jsonMap);
      return responseJson;
    } catch (e) {
      print('Failed to send JSON data: $e');
    }
  }
}