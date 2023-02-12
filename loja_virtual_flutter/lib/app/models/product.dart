class Product {
  String id;
  String category;
  String title;
  String description;
  double price;
  List images;
  List colors;

  Product.fromMap(String idAux, Map<String, dynamic> data) {
    id = idAux;
    title = data["title"];
    description = data["description"];
    price = data["price"] + 0.0;
    images = data["images"];
    colors = data["colors"];
  }

  Map<String, dynamic> toResumeMap() =>
      {"title": title, "description": description, "price": price};
}
