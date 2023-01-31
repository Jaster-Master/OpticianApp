class Location {

  int id;
  String country;
  String zipCode;
  String city;
  String street;
  String streetNumber;

  Location(this.id,
      this.country, this.zipCode, this.city, this.street, this.streetNumber);

  Location.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        country = json['country'],
        zipCode = json['zipCode'],
        city = json['city'],
        street = json['street'],
        streetNumber = json['streetNumber'];

  Map<String, dynamic> toJson() =>
      {
        'ID': id,
        'country': country,
        'zipCode': zipCode,
        'city': city,
        'street': street,
        'streetNumber': streetNumber
      };
}