import 'dart:ffi';

import 'package:intl/intl.dart';

class EyeglassPrescription {
  int id;
  int customerId;
  String forename;
  String surname;
  String type;
  String text;
  DateTime date;
  double sphLeft;
  double sphRight;
  double cylLeft;
  double cylRight;
  double axisLeft;
  double axisRight;
  double addLeft;
  double addRight;
  double prism1Left;
  double prism1Right;
  double basis1Left;
  double basis1Right;
  double prism2Left;
  double prism2Right;
  double basis2Left;
  double basis2Right;
  double pdLeft;
  double pdRight;
  double hightLeft;
  double hightRight;
  double amplification;
  DateTime timestamp;

  EyeglassPrescription(
      this.id,
      this.customerId,
      this.forename,
      this.surname,
      this.type,
      this.text,
      this.date,
      this.sphLeft,
      this.sphRight,
      this.cylLeft,
      this.cylRight,
      this.axisLeft,
      this.axisRight,
      this.addLeft,
      this.addRight,
      this.prism1Left,
      this.prism1Right,
      this.basis1Left,
      this.basis1Right,
      this.prism2Left,
      this.prism2Right,
      this.basis2Left,
      this.basis2Right,
      this.pdLeft,
      this.pdRight,
      this.hightLeft,
      this.hightRight,
      this.amplification,
      this.timestamp);

  EyeglassPrescription.fromJson(Map<String, dynamic> json)
      : id = json['ID'] as int,
        customerId =
            (NumberFormat("######0").parse(json['customerID']) as double)
                .toInt(),
        forename = json['forename'],
        surname = json['surname'],
        type = json['type'],
        text = json['text'],
        date = DateTime.parse(json['date']),
        sphLeft = double.tryParse(json['sphLeft'].toString()) ?? 0,
        sphRight = double.tryParse(json['sphRight'].toString()) ?? 0,
        cylLeft = double.tryParse(json['cylLeft'].toString()) ?? 0,
        cylRight = double.tryParse(json['cylRight'].toString()) ?? 0,
        axisLeft = double.tryParse(json['axisLeft'].toString()) ?? 0,
        axisRight = double.tryParse(json['axisRight'].toString()) ?? 0,
        addLeft = double.tryParse(json['addLeft'].toString()) ?? 0,
        addRight = double.tryParse(json['addRight'].toString()) ?? 0,
        prism1Left = double.tryParse(json['prism1Left'].toString()) ?? 0,
        prism1Right = double.tryParse(json['prism1Right'].toString()) ?? 0,
        basis1Left = double.tryParse(json['basis1Left'].toString()) ?? 0,
        basis1Right = double.tryParse(json['basis1Right'].toString()) ?? 0,
        prism2Left = double.tryParse(json['prism2Left'].toString()) ?? 0,
        prism2Right = double.tryParse(json['prism2Right'].toString()) ?? 0,
        basis2Left = double.tryParse(json['basis2Left'].toString()) ?? 0,
        basis2Right = double.tryParse(json['basis2Right'].toString()) ?? 0,
        pdLeft = double.tryParse(json['pdLeft'].toString()) ?? 0,
        pdRight = double.tryParse(json['pdRight'].toString()) ?? 0,
        hightLeft = double.tryParse(json['hightLeft'].toString()) ?? 0,
        hightRight = double.tryParse(json['hightRight'].toString()) ?? 0,
        amplification = double.tryParse(json['amplification'].toString()) ?? 0,
        timestamp = DateTime.parse(json['timestamp']);

  Map<String, dynamic> toJson() => {
        'ID': id,
        'customerID': NumberFormat("######0").format(customerId),
        'forename': forename,
        'surname': surname,
        'type': type,
        'text': text,
        'date': DateFormat("yyyy-MM-dd").format(date),
        'sphLeft': sphLeft,
        'sphRight': sphRight,
        'cylLeft': cylLeft,
        'cylRight': cylRight,
        'axisLeft': axisLeft,
        'axisRight': axisRight,
        'addLeft': addLeft,
        'addRight': addRight,
        'prism1Left': prism1Left,
        'prism1Right': prism1Right,
        'basis1Left': basis1Left,
        'basis1Right': basis1Right,
        'prism2Left': prism2Left,
        'prism2Right': prism2Right,
        'basis2Left': basis2Left,
        'basis2Right': basis2Right,
        'pdLeft': pdLeft,
        'pdRight': pdRight,
        'hightLeft': hightLeft,
        'hightRight': hightRight,
        'amplification': amplification,
        'timestamp': DateFormat("yyyy-MM-dd HH:mm:ss").format(timestamp),
      };
}
