class User {
  int id;
  String username;
  String password;
  int favouriteOpticianId;
  Map<int, int> favouriteOpticianLocations;

  User(this.id, this.username, this.password, this.favouriteOpticianId,
      this.favouriteOpticianLocations);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        password = json['password'],
        favouriteOpticianId = json['favouriteOpticianId'],
        favouriteOpticianLocations =
            (json['favouriteOpticianLocations'] as Map<String, dynamic>)
                .map((key, value) => MapEntry(int.parse(key), value as int));

  Map<String, dynamic> toJson() => {
        'ID': id,
        'username': username,
        'password': password,
        'favouriteOpticianId': favouriteOpticianId,
        'favouriteOpticianLocations': favouriteOpticianLocations
      };
}
