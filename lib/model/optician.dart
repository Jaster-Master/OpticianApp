import 'location.dart';

class Optician {

  String name;
  String description;
  List<Location> locations;
  String phoneNumber;
  String email;
  String website;
  List<DateTime> availableAppointments;
  bool isFavourite;

  Optician(this.name, this.description, this.locations, this.phoneNumber,
      this.email, this.website, this.availableAppointments, this.isFavourite);
}