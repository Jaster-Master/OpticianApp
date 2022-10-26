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
  double heightLeft;
  double heightRight;
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
      this.heightLeft,
      this.heightRight,
      this.amplification,
      this.timestamp);
}