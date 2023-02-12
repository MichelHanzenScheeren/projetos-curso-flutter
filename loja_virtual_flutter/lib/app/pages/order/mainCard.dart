import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/models/order.dart';
import 'package:lojavirtualflutter/app/models/orderProduct.dart';
import 'package:lojavirtualflutter/app/pages/order/descItemOfOrder.dart';
import 'package:lojavirtualflutter/app/pages/order/orderResum.dart';
import 'package:lojavirtualflutter/app/pages/order/orderStatus.dart';

class MainCard extends StatelessWidget {
  final Order order;
  MainCard(this.order);

  final Color iconColor = Color.fromARGB(245, 225, 225, 225);
  final TextStyle title = TextStyle(
    color: Colors.grey[100],
    fontSize: 19,
    fontWeight: FontWeight.bold,
  );
  final TextStyle subtitle = TextStyle(
    color: Colors.grey[100],
    fontSize: 17,
  );

  String getTotalQuantity(List<OrderProduct> itens) {
    if (itens.length == 0) return "";
    int total = itens.fold(0, (sum, item) {
      return item.quantity + sum;
    });
    return "$total " + (total == 1 ? "item" : "itens");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: ExpansionTile(
        trailing: Icon(Icons.keyboard_arrow_down, color: iconColor),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            myText("Pedido ${order.orderUid}", title),
            myText("Data: ${order.getTime()}", subtitle),
            myText("${getTotalQuantity(order.orderProducts)}", subtitle),
          ],
        ),
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(color: Colors.grey[600]),
                Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: ExpansionTile(
                    trailing: Icon(Icons.arrow_drop_down, color: iconColor),
                    title: myText("Produtos", title),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 7),
                        child: Column(
                          children: order.orderProducts.map((orderProduct) {
                            return DescItemOfOrder(orderProduct, subtitle);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey[600]),
                Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    trailing: Icon(Icons.arrow_drop_down, color: iconColor),
                    title: myText("Resumo", title),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                        child: OrderResum(
                          order.subtotal,
                          order.discount,
                          order.shipping,
                          subtitle,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey[600]),
                SizedBox(height: 10),
                OrderStatus(order.status, title),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget myText(String text, TextStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(text, style: style, textAlign: TextAlign.left),
        SizedBox(height: 2),
      ],
    );
  }
}
