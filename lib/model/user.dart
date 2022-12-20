class User {
  int id;
  String username;
  String password;

  User(this.id, this.username, this.password);

  User.fromJson(Map<String, dynamic> json)
      : id = json['ID'] as int,
        username = json['username'],
        password = json['password'];

  Map<String, dynamic> toJson() =>
      {'ID': id, 'username': username, 'password': password};
}
