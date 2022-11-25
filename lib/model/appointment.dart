import 'package:intl/intl.dart';

class Appointment {
  int id;
  int customerId;
  String type;
  String text;
  DateTime due;
  DateTime timestamp;

  Appointment(
      this.id, this.customerId, this.type, this.text, this.due, this.timestamp);

  Appointment.fromJson(Map<String, dynamic> json)
      : id = json['ID'] as int,
        customerId =
            (NumberFormat("######0").parse(json['customerID']) as double)
                .toInt(),
        type = json['type'],
        text = json['text'],
        due = DateTime.parse(json['due']),
        timestamp = DateTime.parse(json['timestamp']);

  Map<String, dynamic> toJson() => {
        'ID': id,
        'customerID': NumberFormat("######0").format(customerId),
        'type': type,
        'text': text,
        'due': DateFormat("yyyy-MM-dd").format(due),
        'timestamp': DateFormat("yyyy-MM-dd HH:mm:ss").format(timestamp)
      };
}
