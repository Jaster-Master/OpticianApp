import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../default_properties.dart';
import '../../../model/optician.dart';

class PartnerAvailableAppointmentsView extends StatefulWidget {
  Optician partner;

  PartnerAvailableAppointmentsView(this.partner, {super.key});

  @override
  State<StatefulWidget> createState() =>
      PartnerAvailableAppointmentsViewState();
}

class PartnerAvailableAppointmentsViewState
    extends State<PartnerAvailableAppointmentsView> {
  @override
  Widget build(BuildContext context) {
    List<DateTime> selectedDates = widget.partner.availableAppointments;
    Widget calendarBuilder(
        BuildContext context, DateTime date, List<dynamic> events) {
      bool isAvailable = selectedDates.any((element) =>
          element.year == date.year &&
          element.month == date.month &&
          element.day == date.day);
      Color color = isAvailable ? Colors.green : Colors.red;
      return Container(
        width: 10,
        height: 5,
        color: color,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: Icon(Icons.arrow_back)),
                Text("Zurück",
                    style: TextStyle(fontSize: DefaultProperties.fontSize2)),
              ],
            ),
            TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime(2000),
              lastDay: DateTime(2101),
              calendarBuilders:
                  CalendarBuilders(markerBuilder: calendarBuilder),
            ),
          ],
        ),
      ),
    );
  }
}
