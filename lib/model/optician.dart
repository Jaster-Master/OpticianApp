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

  Optician(this.id, this.name, this.description, this.locations,
      this.phoneNumber, this.email, this.website, this.availableAppointments);

  Optician.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        locations = (json['locations'] as List<dynamic>)
            .map((e) => Location.fromJson(e))
            .toList(),
        phoneNumber = json['phoneNumber'],
        email = json['email'],
        website = json['website'],
        availableAppointments = (json['availableAppointments'] as List<dynamic>)
            .map((e) => DateTime.parse(e))
            .toList();

  Map<String, dynamic> toJson() => {
        'ID': id,
        'name': name,
        'description': description,
        'locations': locations,
        'phoneNumber': phoneNumber,
        'email': email,
        'website': website,
        'availableAppointments': availableAppointments
      };
}
