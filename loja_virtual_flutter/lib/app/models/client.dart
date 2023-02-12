class Client {
  String id;
  String email;
  String name;
  String lastName;

  Client(this.email, this.name, this.lastName);

  Client.fromMap(String id, Map<String, dynamic> data) {
    this.id = id;
    email = data["email"];
    name = data["name"];
    lastName = data["lastName"];
  }

  Map<String, dynamic> toMap() =>
      {"email": email, "name": name, "lastName": lastName};
}
