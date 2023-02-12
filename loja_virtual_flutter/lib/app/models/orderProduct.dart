import 'package:lojavirtualflutter/app/models/cartProduct.dart';

class OrderProduct {
  String productUid;
  String categoryUid;

  int quantity;
  String color;
  double price;
  String title;
  String photo;

  OrderProduct.fromCartProduct(CartProduct cartProduct) {
    productUid = cartProduct.productUid;
    categoryUid = cartProduct.categoryUid;
    quantity = cartProduct.quantity;
    color = cartProduct.color;
    price = cartProduct.product.price;
    title = cartProduct.product.title;
    photo = cartProduct.product.images[0];
  }

  OrderProduct.fromMap(Map<dynamic, dynamic> data) {
    productUid = data["productUid"];
    categoryUid = data["categoryUid"];
    quantity = data["quantity"];
    color = data["color"];
    price = data["price"];
    title = data["title"];
    photo = data["photo"];
  }

  Map<String, dynamic> toMap() => {
        "productUid": productUid,
        "categoryUid": categoryUid,
        "quantity": quantity,
        "color": color,
        "price": price,
        "title": title,
        "photo": photo
      };
}
