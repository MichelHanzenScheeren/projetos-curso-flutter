import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/database.dart';
import 'package:lojavirtualflutter/app/models/order.dart';
import 'package:lojavirtualflutter/app/pages/order/mainCard.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';

class OrderItem extends StatefulWidget {
  final String itemUid;
  OrderItem(this.itemUid);

  @override
  _OrderItemState createState() => _OrderItemState(itemUid);
}

class _OrderItemState extends State<OrderItem> {
  String itemUid;
  _OrderItemState(this.itemUid);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      color: Colors.transparent,
      elevation: 1,
      child: FutureBuilder<Order>(
        future: Database.instance.getOrder(itemUid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: 50,
              child: WaitingWidget(height: 40, width: 40),
            );
          } else {
            return MainCard(snapshot.data);
          }
        },
      ),
    );
  }
}
