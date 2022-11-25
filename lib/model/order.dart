import 'package:intl/intl.dart';

class Order {
  int id;
  int customerId;
  String type;
  String text;
  DateTime due;
  bool finished;
  DateTime timestamp;

  Order(this.id, this.customerId, this.type, this.text, this.due, this.finished,
      this.timestamp);

  Order.fromJson(Map<String, dynamic> json)
      : id = json['ID'] as int,
        customerId =
            (NumberFormat("######0").parse(json['customerID']) as double)
                .toInt(),
        type = json['type'],
        text = json['text'],
        due = DateTime.parse(json['due']),
        finished =
            json['finished'].toString().toLowerCase() == "true" ? true : false,
        timestamp = DateTime.parse(json['timestamp']);

  Map<String, dynamic> toJson() => {
        'ID': id,
        'customerID': NumberFormat("######0").format(customerId),
        'type': type,
        'text': text,
        'due': DateFormat("yyyy-MM-dd").format(due),
        'finished': finished,
        'timestamp': DateFormat("yyyy-MM-dd HH:mm:ss").format(timestamp)
      };
}
