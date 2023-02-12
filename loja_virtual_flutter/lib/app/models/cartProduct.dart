import 'package:flutter/cupertino.dart';
import 'package:lojavirtualflutter/app/models/product.dart';

class CartProduct {
  String cartUid;
  String productUid;
  String categoryUid;

  int quantity;
  String color;

  Product product;

  CartProduct({
    @required this.productUid,
    @required this.categoryUid,
    @required this.quantity,
    @required this.color,
  });

  CartProduct.fromMap(String uid, Map data) {
    cartUid = uid;
    productUid = data["productUid"];
    categoryUid = data["categoryUid"];
    quantity = data["quantity"];
    color = data["color"];
  }

  Map<String, dynamic> toMap() => {
        "productUid": productUid,
        "categoryUid": categoryUid,
        "quantity": quantity,
        "color": color
      };
}
