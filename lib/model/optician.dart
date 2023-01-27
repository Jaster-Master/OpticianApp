import 'location.dart';

class Optician {

  int id;
  String name;
  String description;
  List<Location> locations;
  String phoneNumber;
  String email;
  String website;
  List<DateTime> availableAppointments;

  Optician(this.id, this.name, this.description, this.locations, this.phoneNumber,
      this.email, this.website, this.availableAppointments);
}