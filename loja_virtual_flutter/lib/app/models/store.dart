class Store {
  String adress;
  String name;
  double latitude;
  double longitude;
  String phone;
  String photo;

  Store.fromMap(Map<String, dynamic> data) {
    adress = data["adress"];
    name = data["name"];
    latitude = data["latitude"];
    longitude = data["longitude"];
    phone = data["phone"];
    photo = data["photo"];
  }
}
