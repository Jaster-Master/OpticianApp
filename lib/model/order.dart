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
}