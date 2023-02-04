import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }
}
