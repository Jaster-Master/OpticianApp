class Appointment {

  int id;
  int customerId;
  String type;
  String text;
  DateTime due;
  DateTime timestamp;

  Appointment(
      this.id, this.customerId, this.type, this.text, this.due, this.timestamp);
}