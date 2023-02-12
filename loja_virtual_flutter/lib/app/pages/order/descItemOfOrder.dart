import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/models/orderProduct.dart';

class DescItemOfOrder extends StatelessWidget {
  final OrderProduct orderProduct;
  final TextStyle subtitle;
  DescItemOfOrder(this.orderProduct, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Image.network(
              orderProduct.photo,
              fit: BoxFit.cover,
              height: 120,
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${orderProduct.title}",
                      style: subtitle.copyWith(fontSize: 18)),
                  Text(
                    "${orderProduct.quantity} " +
                        (orderProduct.quantity == 1 ? "unidade" : "unidades"),
                    style: subtitle,
                  ),
                  Text(
                    "Valor: R\$${orderProduct.price.toStringAsFixed(2)}",
                    style: subtitle,
                  ),
                  Text("Cor: ${orderProduct.color}", style: subtitle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
