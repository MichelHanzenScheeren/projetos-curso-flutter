import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtualflutter/app/models/orderProduct.dart';
import 'package:date_format/date_format.dart';

class Order {
  String orderUid;
  String userUid;
  double subtotal;
  double shipping;
  double discount;
  List<OrderProduct> orderProducts;
  int status;
  Timestamp orderTime;

  Order({
    @required this.userUid,
    @required this.subtotal,
    @required this.shipping,
    @required this.discount,
    @required this.orderProducts,
    @required this.status,
  }) {
    orderTime = Timestamp.now();
  }

  Order.fromMap(
    String uid,
    Map<String, dynamic> data,
    List orderItems,
  ) {
    orderUid = uid;
    userUid = data["userUid"];
    subtotal = data["subtotal"];
    shipping = data["shipping"];
    discount = data["discount"];
    orderProducts = orderItems.map((doc) {
      return OrderProduct.fromMap(doc);
    }).toList();
    status = data["status"];
    orderTime = data["orderTime"];
  }

  Map<String, dynamic> toMap() => {
        "userUid": userUid,
        "subtotal": subtotal,
        "shipping": shipping,
        "discount": discount,
        "orderProducts": orderProducts.map((doc) => doc.toMap()).toList(),
        "status": status,
        "orderTime": orderTime
      };

  String getTime() {
    var formatter = [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn, 'hrs'];
    return "${formatDate(orderTime.toDate(), formatter)}";
  }
}
